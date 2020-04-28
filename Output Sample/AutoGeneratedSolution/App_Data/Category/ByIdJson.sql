
CREATE PROCEDURE [SpJson].[Category_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
as [Category_UpCategoryId]

,(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

From [Shop].[Category] [category]
Where [category].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
