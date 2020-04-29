
CREATE PROCEDURE [SpJson].[Role_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
Where [role].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
