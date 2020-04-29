
Go
CREATE PROCEDURE [SpJson].[Factor_RestoreData]
    @Id bigint
AS
Update [Shop].[Factor] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[factor].[Id] ,
[factor].[ShippingTypeId] ,
[factor].[ShippingPrice] ,
[factor].[TotalPrice] ,
[factor].[FactorInfoId] ,
[factor].[IsDeleted] ,
[factor].[ModifyDate] ,
[factor].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[factor_shippingtype].[Id] ,
[factor_shippingtype].[Name] ,
[factor_shippingtype].[IsDeleted] ,
[factor_shippingtype].[ModifyDate] ,
[factor_shippingtype].[SubmitDate]

From [Shop].[ShippingType] as factor_shippingtype 
Where factor_shippingtype.[Id] = factor.[ShippingTypeId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [ShippingType_ShippingTypeId_FK]
 ,
 -- End Relation 
(JSON_QUERY((
Select Top(1) 
[factor_factorinfo].[Id] ,
[factor_factorinfo].[PhoneNumber] ,
[factor_factorinfo].[ZipCode] ,
[factor_factorinfo].[Address1] ,
[factor_factorinfo].[Address2] ,
[factor_factorinfo].[IsDeleted] ,
[factor_factorinfo].[ModifyDate] ,
[factor_factorinfo].[SubmitDate]

From [Shop].[FactorInfo] as factor_factorinfo 
Where factor_factorinfo.[Id] = factor.[FactorInfoId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [FactorInfo_FactorInfoId_FK]

	,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[FactorId] = [factor].[Id]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_FactorId]

	From [Shop].[Factor]
	Where 
	[factor].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
