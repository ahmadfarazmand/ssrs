
CREATE PROCEDURE [SpJson].[TempCard_FirstOrDefault]
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@UserInfoId bigint = NULL ,
@MultiText_UserInfoId nvarchar(MAX) = '' ,
@MinUserInfoId bigint = NULL ,
@MaxUserInfoId bigint = NULL ,


@FactorId bigint = NULL ,
@MultiText_FactorId nvarchar(MAX) = '' ,
@MinFactorId bigint = NULL ,
@MaxFactorId bigint = NULL ,


@IsDeleted bit = NULL ,
@MultiText_IsDeleted nvarchar(MAX) = '' ,


@ModifyDate datetimeoffset(7) = NULL ,
@MultiText_ModifyDate nvarchar(MAX) = '' ,
@MinModifyDate datetimeoffset(7) = NULL ,
@MaxModifyDate datetimeoffset(7) = NULL ,


@SubmitDate datetimeoffset(7) = NULL ,
@MultiText_SubmitDate nvarchar(MAX) = '' ,
@MinSubmitDate datetimeoffset(7) = NULL ,
@MaxSubmitDate datetimeoffset(7) = NULL


AS   
	DECLARE @MultiTable_Id TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_Id (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_Id)
	
	Declare @CheckMultiTable_Id Bit = (case when LEN(@MultiText_Id) > 0 And  (select count(*) From @MultiTable_Id) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_UserInfoId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_UserInfoId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_UserInfoId)
	
	Declare @CheckMultiTable_UserInfoId Bit = (case when LEN(@MultiText_UserInfoId) > 0 And  (select count(*) From @MultiTable_UserInfoId) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_FactorId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_FactorId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_FactorId)
	
	Declare @CheckMultiTable_FactorId Bit = (case when LEN(@MultiText_FactorId) > 0 And  (select count(*) From @MultiTable_FactorId) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_IsDeleted TABLE(
	    Item bit
	)
	
	INSERT INTO @MultiTable_IsDeleted (Item)
	SELECT Convert(bit,Item) FROM dbo.SplitString(@MultiText_IsDeleted)
	
	Declare @CheckMultiTable_IsDeleted Bit = (case when LEN(@MultiText_IsDeleted) > 0 And  (select count(*) From @MultiTable_IsDeleted) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_ModifyDate TABLE(
	    Item datetimeoffset(7)
	)
	
	INSERT INTO @MultiTable_ModifyDate (Item)
	SELECT Convert(datetimeoffset(7),Item) FROM dbo.SplitString(@MultiText_ModifyDate)
	
	Declare @CheckMultiTable_ModifyDate Bit = (case when LEN(@MultiText_ModifyDate) > 0 And  (select count(*) From @MultiTable_ModifyDate) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_SubmitDate TABLE(
	    Item datetimeoffset(7)
	)
	
	INSERT INTO @MultiTable_SubmitDate (Item)
	SELECT Convert(datetimeoffset(7),Item) FROM dbo.SplitString(@MultiText_SubmitDate)
	
	Declare @CheckMultiTable_SubmitDate Bit = (case when LEN(@MultiText_SubmitDate) > 0 And  (select count(*) From @MultiTable_SubmitDate) > 0 then 1 Else 0 End)


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

[tempcard_tempcarditem].[Id] ,
[tempcard_tempcarditem].[Count] ,
[tempcard_tempcarditem].[ProductId] ,
[tempcard_tempcarditem].[TempCardId] ,
[tempcard_tempcarditem].[IsDeleted] ,
[tempcard_tempcarditem].[ModifyDate] ,
[tempcard_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [tempcard_tempcarditem]
Where [tempcard_tempcarditem].[IsDeleted] <> 1 And  [tempcard_tempcarditem].[Id] = [tempcard].[TempCardId]
Order by [tempcard_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

From [Shop].[TempCard] [tempcard]
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = tempcard.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= tempcard.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= tempcard.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = tempcard.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @UserInfoId Is Not NULL then case when @UserInfoId = tempcard.[UserInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinUserInfoId Is Not NULL then case when @MinUserInfoId <= tempcard.[UserInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxUserInfoId Is Not NULL then case when @MaxUserInfoId >= tempcard.[UserInfoId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_UserInfoId = 1
			Then case when (Select Count (*) from @MultiTable_UserInfoId Where Item = tempcard.[UserInfoId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @FactorId Is Not NULL then case when @FactorId = tempcard.[FactorId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinFactorId Is Not NULL then case when @MinFactorId <= tempcard.[FactorId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxFactorId Is Not NULL then case when @MaxFactorId >= tempcard.[FactorId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_FactorId = 1
			Then case when (Select Count (*) from @MultiTable_FactorId Where Item = tempcard.[FactorId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [tempcard].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [tempcard].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = tempcard.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= tempcard.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= tempcard.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = tempcard.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = tempcard.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= tempcard.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= tempcard.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = tempcard.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 


