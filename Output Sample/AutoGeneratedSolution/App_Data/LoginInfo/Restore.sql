
Go
CREATE PROCEDURE [SpJson].[LoginInfo_RestoreData]
    @Id bigint
AS
Update [User].[LoginInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
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

	,
	(JSON_QUERY(
(Select Top(30)

[logininfo_userinfo].[Id] ,
[logininfo_userinfo].[FirstName] ,
[logininfo_userinfo].[LastName] ,
[logininfo_userinfo].[IsDeleted] ,
[logininfo_userinfo].[ModifyDate] ,
[logininfo_userinfo].[SubmitDate]




From 
[User].[UserInfo] as [logininfo_userinfo]
Where [logininfo_userinfo].[IsDeleted] <> 1 And  [logininfo_userinfo].[Id] = [logininfo].[UserInfoId]
Order by [logininfo_userinfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [UserInfo_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[logininfo_role].[Id] ,
[logininfo_role].[Name] ,
[logininfo_role].[IsDeleted] ,
[logininfo_role].[ModifyDate] ,
[logininfo_role].[SubmitDate]




From 
[User].[Role] as [logininfo_role]
Where [logininfo_role].[IsDeleted] <> 1 And  [logininfo_role].[Id] = [logininfo].[RoleId]
Order by [logininfo_role].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Role_Id]

	From [User].[LoginInfo]
	Where 
	[logininfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
