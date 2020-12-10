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