Go
CREATE PROCEDURE [SpJson].[Category_UpdateData]
    @Id bigint = NULL ,
@Name nvarchar(150) = NULL ,
@UpCategoryId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[Category] 
Set 
[Name] = @Name, 
[UpCategoryId] = @UpCategoryId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

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
	Where 
	[category].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  




