
Go
CREATE PROCEDURE [SpJson].[ShippingType_DeleteData]
    @Id bigint
AS
Update [Shop].[ShippingType] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[ShippingTypeId] = [shippingtype].[Id]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_ShippingTypeId]

	From [Shop].[ShippingType]
	Where 
	[shippingtype].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
