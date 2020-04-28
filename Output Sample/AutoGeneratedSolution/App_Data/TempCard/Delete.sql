
Go
CREATE PROCEDURE [SpJson].[TempCard_DeleteData]
    @Id bigint
AS
Update [Shop].[TempCard] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcard].[Id] ,
[tempcard].[UserInfoId] ,
[tempcard].[FactorId] ,
[tempcard].[IsDeleted] ,
[tempcard].[ModifyDate] ,
[tempcard].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[tempcard_userinfo].[Id] ,
[tempcard_userinfo].[FirstName] ,
[tempcard_userinfo].[LastName] ,
[tempcard_userinfo].[IsDeleted] ,
[tempcard_userinfo].[ModifyDate] ,
[tempcard_userinfo].[SubmitDate]

From [User].[UserInfo] as tempcard_userinfo 
Where tempcard_userinfo.[Id] = tempcard.[UserInfoId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [UserInfo_UserInfoId]
 ,
 -- End Relation 
(JSON_QUERY((
Select Top(1) 
[tempcard_factor].[Id] ,
[tempcard_factor].[ShippingTypeId] ,
[tempcard_factor].[ShippingPrice] ,
[tempcard_factor].[TotalPrice] ,
[tempcard_factor].[FactorInfoId] ,
[tempcard_factor].[IsDeleted] ,
[tempcard_factor].[ModifyDate] ,
[tempcard_factor].[SubmitDate]

From [Shop].[Factor] as tempcard_factor 
Where tempcard_factor.[Id] = tempcard.[FactorId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Factor_FactorId]

	,(JSON_QUERY(
(Select Top(30)

[tempcard_userinfo].[Id] ,
[tempcard_userinfo].[FirstName] ,
[tempcard_userinfo].[LastName] ,
[tempcard_userinfo].[IsDeleted] ,
[tempcard_userinfo].[ModifyDate] ,
[tempcard_userinfo].[SubmitDate]




From 
[User].[UserInfo] as [tempcard_userinfo]
Where [tempcard_userinfo].[IsDeleted] <> 1 And  [tempcard_userinfo].[Id] = [tempcard].[UserInfoId]
Order by [tempcard_userinfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [UserInfo_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[tempcard_factor].[Id] ,
[tempcard_factor].[ShippingTypeId] ,
[tempcard_factor].[ShippingPrice] ,
[tempcard_factor].[TotalPrice] ,
[tempcard_factor].[FactorInfoId] ,
[tempcard_factor].[IsDeleted] ,
[tempcard_factor].[ModifyDate] ,
[tempcard_factor].[SubmitDate]




From 
[Shop].[Factor] as [tempcard_factor]
Where [tempcard_factor].[IsDeleted] <> 1 And  [tempcard_factor].[Id] = [tempcard].[FactorId]
Order by [tempcard_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[TempCard]
	Where 
	[tempcard].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 
