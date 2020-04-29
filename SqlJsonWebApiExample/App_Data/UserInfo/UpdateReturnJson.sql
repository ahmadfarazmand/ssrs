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

	,
	(JSON_QUERY(
(Select Top(30)

[userinfo_logininfo].[Id] ,
[userinfo_logininfo].[Username] ,
[userinfo_logininfo].[Password] ,
[userinfo_logininfo].[UserInfoId] ,
[userinfo_logininfo].[RoleId] ,
[userinfo_logininfo].[IsDeleted] ,
[userinfo_logininfo].[ModifyDate] ,
[userinfo_logininfo].[SubmitDate]




From 
[User].[LoginInfo] as [userinfo_logininfo]
Where [userinfo_logininfo].[IsDeleted] <> 1 And  [userinfo_logininfo].[Id] = [userinfo].[UserInfoId]
Order by [userinfo_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[userinfo_tempcard].[Id] ,
[userinfo_tempcard].[UserInfoId] ,
[userinfo_tempcard].[FactorId] ,
[userinfo_tempcard].[IsDeleted] ,
[userinfo_tempcard].[ModifyDate] ,
[userinfo_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [userinfo_tempcard]
Where [userinfo_tempcard].[IsDeleted] <> 1 And  [userinfo_tempcard].[Id] = [userinfo].[UserInfoId]
Order by [userinfo_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

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





