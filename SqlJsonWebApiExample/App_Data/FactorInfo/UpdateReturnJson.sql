Go
CREATE PROCEDURE [SpJson].[FactorInfo_UpdateData]
    @Id bigint = NULL ,
@PhoneNumber nvarchar(50) = NULL ,
@ZipCode nvarchar(50) = NULL ,
@Address1 nvarchar(150) = NULL ,
@Address2 nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[FactorInfo] 
Set 
[PhoneNumber] = @PhoneNumber, 
[ZipCode] = @ZipCode, 
[Address1] = @Address1, 
[Address2] = @Address2, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[FactorInfoId] = [factorinfo].[Id]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_FactorInfoId]

	From [Shop].[FactorInfo] [factorinfo]
	Where 
	[factorinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  





