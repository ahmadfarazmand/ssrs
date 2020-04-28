
CREATE PROCEDURE [SpJson].[Product_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]



From [Shop].[Product] [product]
Where [product].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
