
CREATE PROCEDURE [SpJson].[TempCardItem_AddNewData]
    @Count int = NULL ,
@ProductId bigint = NULL ,
@TempCardId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[TempCardItem]
	(Count,ProductId,TempCardId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Count,@ProductId,@TempCardId,@IsDeleted,@ModifyDate,@SubmitDate)
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
	[tempcarditem].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





