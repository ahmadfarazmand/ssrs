
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
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId_FK]

,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[ProductId] = [product].[Id]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_ProductId]

From [Shop].[Product] [product]
Where [product].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
