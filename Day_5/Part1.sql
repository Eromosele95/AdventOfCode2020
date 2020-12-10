SELECT MAX((dbo.BinaryToInt([row]) * 8) + dbo.BinaryToInt([column])) AS SEAT_ID
FROM (
	SELECT REPLACE(REPLACE(SUBSTRING(SeatCode, 1, 7), 'F', '0'), 'B', '1') AS [row],
		REPLACE(REPLACE(SUBSTRING(SeatCode, 8, 3), 'R', '1'), 'L', '0') AS [column]
	FROM dbo.AdventDay5
	) t
