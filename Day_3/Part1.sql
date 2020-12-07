SET STATISTICS IO ON
GO

WITH MyFirstCTE (
	dex
	, Pattern
	, Num
	, const
	)
AS (
	-- Omit the first row 
	SELECT 3 AS Currentdex
		, column2
		,
		-- SUBSTRING(column2, 4, 1) AS CurChar, 
		column1 AS CurStep
		, 3 AS ModCnst
	FROM dbo.AdventDay3Clean
	WHERE column1 = 2
	
	UNION ALL
	
	SELECT (dex + fc.const) % 31 AS Newdex
		, column2
		,
		-- SUBSTRING(column2,(dex-1+const) % 31+1 , 1) AS NextChar, --This Logic is probably wrong....
		Num + 1 AS NextStep
		, 3 AS ModConst
	FROM dbo.AdventDay3Clean d3
	JOIN MyFirstCTE fc ON fc.Num = d3.column1
	)
SELECT DISTINCT SUBSTRING(d3.column2, dex + 1, 1)
	, count(*)
FROM MyFirstCTE ct
INNER JOIN dbo.AdventDay3Clean d3 ON ct.Num = d3.column1
--Had to do a rejoin since the first record was omitted on this table
GROUP BY SUBSTRING(d3.column2, dex + 1, 1)
OPTION (MAXRECURSION 400)
