
Go
CREATE PROCEDURE [SpJson].[UserInfo_RestoreData]
    @Id bigint
AS
Update [User].[UserInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
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

	
	
	From [User].[UserInfo]
	Where 
	[userinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
