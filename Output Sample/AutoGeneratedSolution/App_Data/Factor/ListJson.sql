
CREATE PROCEDURE [SpJson].[Factor_ToList]
	@TopCount int = 200,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@ShippingTypeId bigint = NULL ,
@MultiText_ShippingTypeId nvarchar(MAX) = '' ,
@MinShippingTypeId bigint = NULL ,
@MaxShippingTypeId bigint = NULL ,


@ShippingPrice float = NULL ,
@MultiText_ShippingPrice nvarchar(MAX) = '' ,
@MinShippingPrice float = NULL ,
@MaxShippingPrice float = NULL ,


@TotalPrice float = NULL ,
@MultiText_TotalPrice nvarchar(MAX) = '' ,
@MinTotalPrice float = NULL ,
@MaxTotalPrice float = NULL ,


@FactorInfoId bigint = NULL ,
@MultiText_FactorInfoId nvarchar(MAX) = '' ,
@MinFactorInfoId bigint = NULL ,
@MaxFactorInfoId bigint = NULL ,


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

	DECLARE @MultiTable_ShippingTypeId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_ShippingTypeId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_ShippingTypeId)
	
	Declare @CheckMultiTable_ShippingTypeId Bit = (case when LEN(@MultiText_ShippingTypeId) > 0 And  (select count(*) From @MultiTable_ShippingTypeId) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_ShippingPrice TABLE(
	    Item float
	)
	
	INSERT INTO @MultiTable_ShippingPrice (Item)
	SELECT Convert(float,Item) FROM dbo.SplitString(@MultiText_ShippingPrice)
	
	Declare @CheckMultiTable_ShippingPrice Bit = (case when LEN(@MultiText_ShippingPrice) > 0 And  (select count(*) From @MultiTable_ShippingPrice) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_TotalPrice TABLE(
	    Item float
	)
	
	INSERT INTO @MultiTable_TotalPrice (Item)
	SELECT Convert(float,Item) FROM dbo.SplitString(@MultiText_TotalPrice)
	
	Declare @CheckMultiTable_TotalPrice Bit = (case when LEN(@MultiText_TotalPrice) > 0 And  (select count(*) From @MultiTable_TotalPrice) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_FactorInfoId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_FactorInfoId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_FactorInfoId)
	
	Declare @CheckMultiTable_FactorInfoId Bit = (case when LEN(@MultiText_FactorInfoId) > 0 And  (select count(*) From @MultiTable_FactorInfoId) > 0 then 1 Else 0 End)

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


Select Top(@TopCount)
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

,(Select Count(*)
From 
[Shop].[ShippingType] as [factor_shippingtype]
Where [factor_shippingtype].[IsDeleted] <> 1 And [factor_shippingtype].[Id] = [factor].[ShippingTypeId]) 
as [ShippingType_IdCount]
 ,
 -- End Relation 
(Select Count(*)
From 
[Shop].[FactorInfo] as [factor_factorinfo]
Where [factor_factorinfo].[IsDeleted] <> 1 And [factor_factorinfo].[Id] = [factor].[FactorInfoId]) 
as [FactorInfo_IdCount]

From [Shop].[Factor] factor
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = factor.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= factor.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= factor.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = factor.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ShippingTypeId Is Not NULL then case when @ShippingTypeId = factor.[ShippingTypeId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinShippingTypeId Is Not NULL then case when @MinShippingTypeId <= factor.[ShippingTypeId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxShippingTypeId Is Not NULL then case when @MaxShippingTypeId >= factor.[ShippingTypeId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ShippingTypeId = 1
			Then case when (Select Count (*) from @MultiTable_ShippingTypeId Where Item = factor.[ShippingTypeId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ShippingPrice Is Not NULL then case when @ShippingPrice = factor.[ShippingPrice] then 1 else 0 end  else 1 end) And
		1 = (case when @MinShippingPrice Is Not NULL then case when @MinShippingPrice <= factor.[ShippingPrice] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxShippingPrice Is Not NULL then case when @MaxShippingPrice >= factor.[ShippingPrice] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ShippingPrice = 1
			Then case when (Select Count (*) from @MultiTable_ShippingPrice Where Item = factor.[ShippingPrice]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @TotalPrice Is Not NULL then case when @TotalPrice = factor.[TotalPrice] then 1 else 0 end  else 1 end) And
		1 = (case when @MinTotalPrice Is Not NULL then case when @MinTotalPrice <= factor.[TotalPrice] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxTotalPrice Is Not NULL then case when @MaxTotalPrice >= factor.[TotalPrice] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_TotalPrice = 1
			Then case when (Select Count (*) from @MultiTable_TotalPrice Where Item = factor.[TotalPrice]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @FactorInfoId Is Not NULL then case when @FactorInfoId = factor.[FactorInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinFactorInfoId Is Not NULL then case when @MinFactorInfoId <= factor.[FactorInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxFactorInfoId Is Not NULL then case when @MaxFactorInfoId >= factor.[FactorInfoId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_FactorInfoId = 1
			Then case when (Select Count (*) from @MultiTable_FactorInfoId Where Item = factor.[FactorInfoId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [factor].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [factor].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = factor.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= factor.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= factor.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = factor.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = factor.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= factor.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= factor.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = factor.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By factor.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 