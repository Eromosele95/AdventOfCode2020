SELECT count(*)
FROM dbo.AdventDay2
WHERE LEN(column3) - LEN(REPLACE(column3, SUBSTRING(column2, 1, 1), '')) >= CAST(LEFT(column1, CHARINDEX('-', column1) - 1) AS INT) --Left Side Always Valid 
	AND LEN(column3) - LEN(REPLACE(column3, SUBSTRING(column2, 1, 1), '')) <= CASE 
		WHEN LEN(column1) = 4
			THEN CAST(RIGHT(column1, CHARINDEX('-', column1)) AS INT)
		ELSE -- depeding on format of right side i.e (1-5), (2-10), (10-12),
			-- indexing would differ, so one will have to check
			CAST(RIGHT(column1, CHARINDEX('-', column1) - 1) AS INT)
		END