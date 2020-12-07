SET STATISTICS IO ON

SELECT
	-- CASE WHEN 
	CAST(SUBSTRING(Passports, PATINDEX('%byr%', Passports) + 4, 4) AS INT) AS byr
	, CAST(SUBSTRING(Passports, PATINDEX('%iyr%', Passports) + 4, 4) AS INT) AS iyr
	, CAST(SUBSTRING(Passports, PATINDEX('%eyr%', Passports) + 4, 4) AS INT) AS eyr
	, SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 5) AS hgt
	, SUBSTRING(Passports, PATINDEX('%hcl%', Passports) + 4, 7) AS hcl
	, SUBSTRING(Passports, PATINDEX('%ecl%', Passports) + 4, 3) AS ecl
	, SUBSTRING(Passports, PATINDEX('%pid%', Passports) + 4, 10) AS pid
	, --select 10 for checking purposes later
	CASE 
		WHEN (SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6)) LIKE '%in%'
			THEN LEFT(SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6), PATINDEX('%in%', SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6)) - 1)
		END AS hgt_in
	, CASE 
		WHEN (SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6)) LIKE '%cm%'
			THEN LEFT(SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6), PATINDEX('%cm%', SUBSTRING(Passports, PATINDEX('%hgt%', Passports) + 4, 6)) - 1)
		END AS hgt_cm
INTO #TempTable
FROM (
	SELECT Passports
		, CASE 
			WHEN Passports LIKE '%byr%'
				AND Passports LIKE '%iyr%'
				AND Passports LIKE '%eyr%'
				AND Passports LIKE '%hgt%'
				AND Passports LIKE '%hcl%'
				AND Passports LIKE '%ecl%'
				AND Passports LIKE '%pid%'
				THEN 1
			ELSE 0
			END AS isValid
		, CASE 
			WHEN Passports LIKE '%cid%'
				THEN 1
			ELSE 0
			END AS cidValid
	--  Passports LIKE '%cid%' 
	FROM dbo.AdventDay4Cleaned
	) t
WHERE t.isValid = 1
	OR (
		t.isValid = 1
		AND t.cidValid = 1
		)

------SIMPLE SELECT TO GET FINAL RESULTS
SELECT count(*)
FROM #TempTable
WHERE (
		byr >= 1920
		AND byr <= 2002
		AND iyr >= 2010
		AND iyr <= 2020
		AND eyr >= 2020
		AND eyr <= 2030
		AND (
			CAST(hgt_in AS INT) >= 59
			AND CAST(hgt_in AS INT) <= 76
			OR CAST(hgt_cm AS INT) >= 150
			AND CAST(hgt_cm AS INT) <= 193
			)
		AND (
			SUBSTRING(hcl, 1, 1) = '#'
			AND SUBSTRING(hcl, 2, 7) LIKE '[A-F0-9][A-F0-9][A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
			)
		AND ecl IN ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth')
		AND (
			ISNUMERIC(SUBSTRING(pid, 1, 10)) = 1
			AND LEN(SUBSTRING(pid, 1, 10)) = 9 --valid pids
			OR ISNUMERIC(SUBSTRING(pid, 1, 9)) = 1
			AND ISNUMERIC(SUBSTRING(pid, 1, 10)) = 0 -- Account for Cases when extra characters are taken 
			)
		)

DROP TABLE #TempTable