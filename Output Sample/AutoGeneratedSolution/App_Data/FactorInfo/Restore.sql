
Go
CREATE PROCEDURE [SpJson].[FactorInfo_RestoreData]
    @Id bigint
AS
Update [Shop].[FactorInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[factorinfo].[Id] ,
[factorinfo].[PhoneNumber] ,
[factorinfo].[ZipCode] ,
[factorinfo].[Address1] ,
[factorinfo].[Address2] ,
[factorinfo].[IsDeleted] ,
[factorinfo].[ModifyDate] ,
[factorinfo].[SubmitDate]

	
	
	From [Shop].[FactorInfo]
	Where 
	[factorinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
