SET STATISTICS IO ON 
GO

WITH MyFirstCTE (dex,Pattern,Num,const) AS 
(

	-- Omit the first row 
    SELECT 3 AS Currentdex,
    column2,
    -- SUBSTRING(column2, 4, 1) AS CurChar, 
    column1 AS CurStep,
    3 AS ModCnst
    from dbo.AdventDay3Clean
    where column1 = 2

    union ALL

    select (dex+fc.const) % 31 AS Newdex,
    column2,
    -- SUBSTRING(column2,(dex-1+const) % 31+1 , 1) AS NextChar, --This Logic is probably wrong....
    Num+1 AS NextStep,
    3 As ModConst
    from dbo.AdventDay3Clean d3
    join MyFirstCTE fc
    on fc.Num= d3.column1

)
SELECT distinct SUBSTRING(d3.column2,dex+1,1), count(*) FROM MyFirstCTE ct
inner join dbo.AdventDay3Clean d3 on ct.Num =d3.column1
--Had to do a rejoin since the first record was omitted on this table
GROUP by SUBSTRING(d3.column2,dex+1,1)
OPTION(MAXRECURSION 400)



-- RE USED THE SAME logic for Second Part--
-- Currentdex is the right shift and ModCnst is the index
-- NextStep is the downward shift