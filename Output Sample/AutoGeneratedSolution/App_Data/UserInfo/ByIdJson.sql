
CREATE PROCEDURE [SpJson].[UserInfo_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
Where [userinfo].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
