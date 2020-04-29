
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login]
    
@Username nvarchar(70) = NULL ,
@Password nvarchar(170) = NULL 
AS   
With DataForJson
As
(
Select Top(1)
[logininfo].[Id] ,
[logininfo].[Username] ,
[role].[Name] as [Role]

From [User].[LoginInfo] [logininfo]
left join [User].[Role] as [role] on role.Id = [logininfo].RoleId
Where Username = @Username And Password = @Password
)



Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
