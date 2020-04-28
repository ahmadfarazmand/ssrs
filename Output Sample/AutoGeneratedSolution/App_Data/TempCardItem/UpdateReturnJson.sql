Go
CREATE PROCEDURE [SpJson].[TempCardItem_UpdateData]
    @Id bigint = NULL ,
@Count int = NULL ,
@ProductId bigint = NULL ,
@TempCardId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[TempCardItem] 
Set 
[Count] = @Count, 
[ProductId] = @ProductId, 
[TempCardId] = @TempCardId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[tempcarditem_product].[Id] ,
[tempcarditem_product].[Price] ,
[tempcarditem_product].[Count] ,
[tempcarditem_product].[Title] ,
[tempcarditem_product].[OffPercent] ,
[tempcarditem_product].[IsDeleted] ,
[tempcarditem_product].[ModifyDate] ,
[tempcarditem_product].[SubmitDate]




From 
[Shop].[Product] as [tempcarditem_product]
Where [tempcarditem_product].[IsDeleted] <> 1 And  [tempcarditem_product].[Id] = [tempcarditem].[ProductId]
Order by [tempcarditem_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[tempcarditem_tempcard].[Id] ,
[tempcarditem_tempcard].[UserInfoId] ,
[tempcarditem_tempcard].[FactorId] ,
[tempcarditem_tempcard].[IsDeleted] ,
[tempcarditem_tempcard].[ModifyDate] ,
[tempcarditem_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [tempcarditem_tempcard]
Where [tempcarditem_tempcard].[IsDeleted] <> 1 And  [tempcarditem_tempcard].[Id] = [tempcarditem].[TempCardId]
Order by [tempcarditem_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

	From [Shop].[TempCardItem] [tempcarditem]
	Where 
	[tempcarditem].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





