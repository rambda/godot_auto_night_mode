################################################################################
#	Algorithm Source:
#	Almanac for Computers, 1990
#	published by Nautical Almanac Office
#	United States Naval Observatory
#	Washington, DC 20392
################################################################################
enum { SUNRISE, SUNSET }

static func calc_sun_time(longitude: float, latitude: float, sun_time: int, zenith := 90.8) -> float:

	var now = OS.get_datetime()
	var day = now.day
	var month = now.month
	var year =now.year

	var TO_RAD := PI/180

	#1. first calculate the day of the year
	var N1 = floor(275 * month / 9)
	var N2 = floor((month + 9) / 12)
	var N3 = (1 + floor((year - 4 * floor(year / 4) + 2) / 3))
	var N = N1 - (N2 * N3) + day - 30

	#2. convert the longitude to hour value and calculate an approximate time
	var lngHour := longitude / 15

	var t: float
	match sun_time:
		SUNRISE:
			t = N + ((6 - lngHour) / 24)
		SUNSET: #sunset
			t = N + ((18 - lngHour) / 24)

	#3. calculate the Sun's mean anomaly
	var M := (0.9856 * t) - 3.289

	#4. calculate the Sun's true longitude
	var L := M + (1.916 * sin(TO_RAD*M)) + (0.020 * sin(TO_RAD * 2 * M)) + 282.634
	L = fposmod( L, 360 ) #NOTE: L adjusted into the range [0,360)

	#5a. calculate the Sun's right ascension

	var RA := (1/TO_RAD) * atan(0.91764 * tan(TO_RAD*L))
	RA = fposmod( RA, 360 ) #NOTE: RA adjusted into the range [0,360)

	#5b. right ascension value needs to be in the same quadrant as L
	var Lquadrant  := (floor(L/90)) * 90
	var RAquadrant := (floor(RA/90)) * 90
	RA = RA + (Lquadrant - RAquadrant)

	#5c. right ascension value needs to be converted into hours
	RA = RA / 15

	#6. calculate the Sun's declination
	var sinDec := 0.39782 * sin(TO_RAD*L)
	var cosDec := cos(asin(sinDec))

	#7a. calculate the Sun's local hour angle
	var cosH := (cos(TO_RAD*zenith) - (sinDec * sin(TO_RAD*latitude))) / (cosDec * cos(TO_RAD*latitude))

	if cosH > 1:
		print("the sun never rises on this location (on the specified date).")
		return -1.0

	if cosH < -1:
		print("the sun never rises on this location (on the specified date).")
		return -1.0

	#7b. finish calculating H and convert into hours
	var H: float
	match sun_time:
		SUNRISE:
			H = 360 - (1/TO_RAD) * acos(cosH)
		SUNSET: #setting
			H = (1/TO_RAD) * acos(cosH)

	H = H / 15

	#8. calculate local mean time of rising/setting
	var T := H + RA - (0.06571 * t) - 6.622

	#9. adjust back to UTC
	var UT := T - lngHour
	UT = fposmod( UT, 24) # UTC time in decimal format (e.g. 23.23)

	print('coordinate is valid')
	return UT
