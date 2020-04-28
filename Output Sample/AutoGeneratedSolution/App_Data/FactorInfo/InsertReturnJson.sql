
CREATE PROCEDURE [SpJson].[FactorInfo_AddNewData]
    @PhoneNumber nvarchar(50) = NULL ,
@ZipCode nvarchar(50) = NULL ,
@Address1 nvarchar(150) = NULL ,
@Address2 nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[FactorInfo]
	(PhoneNumber,ZipCode,Address1,Address2,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@PhoneNumber,@ZipCode,@Address1,@Address2,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[factorinfo].[Id] ,
[factorinfo].[PhoneNumber] ,
[factorinfo].[ZipCode] ,
[factorinfo].[Address1] ,
[factorinfo].[Address2] ,
[factorinfo].[IsDeleted] ,
[factorinfo].[ModifyDate] ,
[factorinfo].[SubmitDate]

	
	
	From [Shop].[FactorInfo] [factorinfo]
	Where 
	[factorinfo].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





