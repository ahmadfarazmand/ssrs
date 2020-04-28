
CREATE PROCEDURE [SpJson].[ShippingType_AddNewData]
    @Name nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[ShippingType]
	(Name,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Name,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	
	
	From [Shop].[ShippingType] [shippingtype]
	Where 
	[shippingtype].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





