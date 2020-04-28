
Go
CREATE PROCEDURE [SpJson].[Product_RestoreData]
    @Id bigint
AS
Update [Shop].[Product] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
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

	
	
	From [Shop].[Product]
	Where 
	[product].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
