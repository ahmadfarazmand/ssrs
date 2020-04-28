Go
CREATE PROCEDURE [SpJson].[UserInfo_UpdateData]
    @Id bigint = NULL ,
@FirstName nvarchar(100) = NULL ,
@LastName nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[UserInfo] 
Set 
[FirstName] = @FirstName, 
[LastName] = @LastName, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[userinfo].[Id] ,
[userinfo].[FirstName] ,
[userinfo].[LastName] ,
[userinfo].[IsDeleted] ,
[userinfo].[ModifyDate] ,
[userinfo].[SubmitDate]

	
	
	From [User].[UserInfo] [userinfo]
	Where 
	[userinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





