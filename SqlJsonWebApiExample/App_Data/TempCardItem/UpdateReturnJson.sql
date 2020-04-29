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





