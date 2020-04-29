
Go
CREATE PROCEDURE [SpJson].[Category_DeleteData]
    @Id bigint
AS
Update [Shop].[Category] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[category].[Id] ,
[category].[Name] ,
[category].[UpCategoryId] ,
[category].[IsDeleted] ,
[category].[ModifyDate] ,
[category].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]

From [Shop].[Category] as category_category 
Where category_category.[Id] = category.[UpCategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_UpCategoryId_FK]

	,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[CategoryId] = [category].[Id]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_CategoryId]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[UpCategoryId] = [category].[Id]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_UpCategoryId]

	From [Shop].[Category]
	Where 
	[category].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
