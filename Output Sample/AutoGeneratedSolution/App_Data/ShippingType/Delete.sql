
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

	
	
	From [Shop].[ShippingType]
	Where 
	[shippingtype].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
