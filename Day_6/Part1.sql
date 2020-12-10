-- Remove Duplicates from string to get unique votes
CREATE FUNCTION [dbo].[RemoveDupsClean](@str VARCHAR(500))
  RETURNS varchar(500)
  BEGIN
  DECLARE
          @result VARCHAR(500)='',--new string
          @i INT=0,
          @is INT,
          @c NVARCHAR(1)

          while @i<=LEN(@str)
          BEGIN
          SET @i=@i+1
          SET @c=substring(@str,@i,1)
          SET @is =CHARINDEX(@c,@result)
          IF @IS=0
          BEGIN
          SET @result=@result+@c
          END

          END
          return @result
        END

select SUM(LEN(dbo.RemoveDupsClean(column1))) from dbo.AdventDay6



-- CREATE FUNCTION dbo.RemoveDupChars (@S VARCHAR(8000))
-- RETURNS TABLE
-- 	WITH SCHEMABINDING
--
-- RETURN
-- WITH TallyTable(N) AS (
-- 		SELECT ROW_NUMBER() OVER (
-- 				ORDER BY (
-- 						SELECT NULL
-- 						)
-- 				)
-- 		FROM (
-- 			VALUES (0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0)
-- 			) a(n)
-- 		CROSS JOIN (
-- 			VALUES (0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0),
-- 				(0)
-- 			) c(n)
-- 		)
--
-- SELECT OriginalString = @S,
-- 	NewString = (
-- 		SELECT '' + s
-- 		FROM (
-- 			SELECT n,
-- 				s
-- 			FROM (
-- 				-- Choose First Element
-- 				SELECT n = 1,
-- 					s = LEFT(@S, 1)
--
-- 				UNION ALL
--
-- 				SELECT N,
-- 					CASE
-- 						WHEN RIGHT(@S, LEN(@S) - N) NOT LIKE CONCAT (
-- 								'%',
-- 								SUBSTRING(@S, N, 1),
-- 								'%'
-- 								)
-- 							--If the right portion of the string is not like the left character being added
-- 							AND SUBSTRING(@S, N - 1, 1) <> SUBSTRING(@S, N, 1)
-- 							-- If the character being added is not equal to the successive
-- 							THEN SUBSTRING(@S, N, 1)
-- 						END
-- 				FROM TallyTable
-- 				WHERE N BETWEEN 2
-- 						AND LEN(@S)
-- 				) a
-- 			--Filter NULLS
-- 			WHERE s IS NOT NULL
-- 			) b
-- 		ORDER BY n
-- 		FOR XML PATH(''),
-- 			TYPE
-- 		).value('.', 'VARCHAR(8000)');