SET STATISTICS IO ON
-- Part Two
-- First insert only Row_number() into Table and join on table to find out missing seats
-- Search, skipping first 10 and last 10 seats

SELECT ROW_NUMBER() OVER (
		ORDER BY g.SEAT_ID ASC
		) AS ROWNUM
into #Temp
FROM (
	SELECT (dbo.BinaryToInt([row]) * 8) + dbo.BinaryToInt([column]) AS SEAT_ID
	FROM (
		SELECT REPLACE(REPLACE(SUBSTRING(SeatCode, 1, 7), 'F', '0'), 'B', '1') AS [row]
			, REPLACE(REPLACE(SUBSTRING(SeatCode, 8, 3), 'R', '1'), 'L', '0') AS [column]
		FROM dbo.AdventDay5
		) t
	) g


SELECT 
    g.SEAT_ID,
	 t.ROWNUM
-- ROW_NUMBER() OVER (ORDER BY g.SEAT_ID ASC) AS ROWNUM
-- into #Temp
FROM (
	SELECT (dbo.BinaryToInt([row]) * 8) + dbo.BinaryToInt([column]) AS SEAT_ID
	FROM (
		SELECT REPLACE(REPLACE(SUBSTRING(SeatCode, 1, 7), 'F', '0'), 'B', '1') AS [row]
			, REPLACE(REPLACE(SUBSTRING(SeatCode, 8, 3), 'R', '1'), 'L', '0') AS [column]
		FROM dbo.AdventDay5
		) t
	) g
FULL JOIN #Temp t ON g.SEAT_ID = t.ROWNUM
WHERE g.SEAT_ID IS NULL 
AND t.ROWNUM >50 AND t.ROWNUM <884
ORDER BY g.SEAT_ID
	, t.ROWNUM

