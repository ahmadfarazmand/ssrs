
CREATE PROCEDURE [SpJson].[Role_AddNewData]
    @Name nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [User].[Role]
	(Name,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Name,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[role].[Id] ,
[role].[Name] ,
[role].[IsDeleted] ,
[role].[ModifyDate] ,
[role].[SubmitDate]

	
	
	From [User].[Role] [role]
	Where 
	[role].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





