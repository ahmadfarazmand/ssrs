Go
CREATE PROCEDURE [SpJson].[Role_UpdateData]
    @Id bigint = NULL ,
@Name nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[Role] 
Set 
[Name] = @Name, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

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

	,
	(JSON_QUERY(
(Select Top(30)

[role_logininfo].[Id] ,
[role_logininfo].[Username] ,
[role_logininfo].[Password] ,
[role_logininfo].[UserInfoId] ,
[role_logininfo].[RoleId] ,
[role_logininfo].[IsDeleted] ,
[role_logininfo].[ModifyDate] ,
[role_logininfo].[SubmitDate]




From 
[User].[LoginInfo] as [role_logininfo]
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[RoleId] = [role].[Id]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_RoleId]

	From [User].[Role] [role]
	Where 
	[role].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





