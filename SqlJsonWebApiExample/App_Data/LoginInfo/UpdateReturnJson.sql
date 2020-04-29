Go
CREATE PROCEDURE [SpJson].[LoginInfo_UpdateData]
    @Id bigint = NULL ,
@Username nvarchar(100) = NULL ,
@Password nvarchar(100) = NULL ,
@UserInfoId bigint = NULL ,
@RoleId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[LoginInfo] 
Set 
[Username] = @Username, 
[Password] = @Password, 
[UserInfoId] = @UserInfoId, 
[RoleId] = @RoleId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

	
	
	From [User].[LoginInfo] [logininfo]
	Where 
	[logininfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





