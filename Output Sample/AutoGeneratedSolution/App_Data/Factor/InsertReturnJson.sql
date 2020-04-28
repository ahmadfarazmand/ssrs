
CREATE PROCEDURE [SpJson].[Factor_AddNewData]
    @ShippingTypeId bigint = NULL ,
@ShippingPrice float = NULL ,
@TotalPrice float = NULL ,
@FactorInfoId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[Factor]
	(ShippingTypeId,ShippingPrice,TotalPrice,FactorInfoId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@ShippingTypeId,@ShippingPrice,@TotalPrice,@FactorInfoId,@IsDeleted,@ModifyDate,@SubmitDate)
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
as [ShippingType_ShippingTypeId]
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
as [FactorInfo_FactorInfoId]

	,(JSON_QUERY(
(Select Top(30)

[factor_shippingtype].[Id] ,
[factor_shippingtype].[Name] ,
[factor_shippingtype].[IsDeleted] ,
[factor_shippingtype].[ModifyDate] ,
[factor_shippingtype].[SubmitDate]




From 
[Shop].[ShippingType] as [factor_shippingtype]
Where [factor_shippingtype].[IsDeleted] <> 1 And  [factor_shippingtype].[Id] = [factor].[ShippingTypeId]
Order by [factor_shippingtype].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [ShippingType_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[factor_factorinfo].[Id] ,
[factor_factorinfo].[PhoneNumber] ,
[factor_factorinfo].[ZipCode] ,
[factor_factorinfo].[Address1] ,
[factor_factorinfo].[Address2] ,
[factor_factorinfo].[IsDeleted] ,
[factor_factorinfo].[ModifyDate] ,
[factor_factorinfo].[SubmitDate]




From 
[Shop].[FactorInfo] as [factor_factorinfo]
Where [factor_factorinfo].[IsDeleted] <> 1 And  [factor_factorinfo].[Id] = [factor].[FactorInfoId]
Order by [factor_factorinfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [FactorInfo_Id]

	From [Shop].[Factor] [factor]
	Where 
	[factor].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





