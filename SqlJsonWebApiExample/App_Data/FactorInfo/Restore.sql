
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

	,
	(JSON_QUERY(
(Select Top(30)

[factorinfo_factor].[Id] ,
[factorinfo_factor].[ShippingTypeId] ,
[factorinfo_factor].[ShippingPrice] ,
[factorinfo_factor].[TotalPrice] ,
[factorinfo_factor].[FactorInfoId] ,
[factorinfo_factor].[IsDeleted] ,
[factorinfo_factor].[ModifyDate] ,
[factorinfo_factor].[SubmitDate]




From 
[Shop].[Factor] as [factorinfo_factor]
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[FactorInfo]
	Where 
	[factorinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
