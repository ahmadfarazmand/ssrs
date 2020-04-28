
CREATE PROCEDURE [SpJson].[ShippingType_FirstOrDefaultById]
    @Id bigint = Null
AS   

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



From [Shop].[ShippingType] [shippingtype]
Where [shippingtype].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
