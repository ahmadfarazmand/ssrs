
Go
CREATE PROCEDURE [SpJson].[Role_DeleteData]
    @Id bigint
AS
Update [User].[Role] 
Set 
[IsDeleted] = 1
Where Id = @Id

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

	
	
	From [User].[Role]
	Where 
	[role].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
