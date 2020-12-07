SELECT count(*)
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