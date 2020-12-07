SELECT *
FROM (
	SELECT CASE 
			WHEN (SUBSTRING(column3, CAST(LEFT(column1, CHARINDEX('-', column1) - 1) AS INT), 1) = SUBSTRING(column2, 1, 1))
				THEN 1
			ELSE 0
			END AS fcond
		, CASE 
			WHEN LEN(column1) = 4
				THEN CASE 
						WHEN SUBSTRING(column3, CAST(RIGHT(column1, CHARINDEX('-', column1)) AS INT), 1) = SUBSTRING(column2, 1, 1)
							THEN 1
						ELSE 0
						END
			WHEN LEN(column1) <> 4
				THEN CASE 
						WHEN SUBSTRING(column3, CAST(RIGHT(column1, CHARINDEX('-', column1) - 1) AS INT), 1) = SUBSTRING(column2, 1, 1)
							THEN 1
						ELSE 0
						END
			END AS scond
		, *
	FROM dbo.AdventDay2
	) BadLogic
WHERE BadLogic.fcond + BadLogic.scond = 1


-- Messy Logic, but adapted code for the first
-- Idea here is to still check right side indexing
