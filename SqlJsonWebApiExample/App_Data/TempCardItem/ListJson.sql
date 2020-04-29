
CREATE PROCEDURE [SpJson].[TempCardItem_ToList]
	@TopCount int = 200,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Count int = NULL ,
@MultiText_Count nvarchar(MAX) = '' ,
@MinCount int = NULL ,
@MaxCount int = NULL ,


@ProductId bigint = NULL ,
@MultiText_ProductId nvarchar(MAX) = '' ,
@MinProductId bigint = NULL ,
@MaxProductId bigint = NULL ,


@TempCardId bigint = NULL ,
@MultiText_TempCardId nvarchar(MAX) = '' ,
@MinTempCardId bigint = NULL ,
@MaxTempCardId bigint = NULL ,


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

	DECLARE @MultiTable_Count TABLE(
	    Item int
	)
	
	INSERT INTO @MultiTable_Count (Item)
	SELECT Convert(int,Item) FROM dbo.SplitString(@MultiText_Count)
	
	Declare @CheckMultiTable_Count Bit = (case when LEN(@MultiText_Count) > 0 And  (select count(*) From @MultiTable_Count) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_ProductId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_ProductId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_ProductId)
	
	Declare @CheckMultiTable_ProductId Bit = (case when LEN(@MultiText_ProductId) > 0 And  (select count(*) From @MultiTable_ProductId) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_TempCardId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_TempCardId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_TempCardId)
	
	Declare @CheckMultiTable_TempCardId Bit = (case when LEN(@MultiText_TempCardId) > 0 And  (select count(*) From @MultiTable_TempCardId) > 0 then 1 Else 0 End)

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
[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]



From [Shop].[TempCardItem] tempcarditem
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = tempcarditem.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= tempcarditem.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= tempcarditem.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = tempcarditem.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Count Is Not NULL then case when @Count = tempcarditem.[Count] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCount Is Not NULL then case when @MinCount <= tempcarditem.[Count] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCount Is Not NULL then case when @MaxCount >= tempcarditem.[Count] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Count = 1
			Then case when (Select Count (*) from @MultiTable_Count Where Item = tempcarditem.[Count]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ProductId Is Not NULL then case when @ProductId = tempcarditem.[ProductId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinProductId Is Not NULL then case when @MinProductId <= tempcarditem.[ProductId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxProductId Is Not NULL then case when @MaxProductId >= tempcarditem.[ProductId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ProductId = 1
			Then case when (Select Count (*) from @MultiTable_ProductId Where Item = tempcarditem.[ProductId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @TempCardId Is Not NULL then case when @TempCardId = tempcarditem.[TempCardId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinTempCardId Is Not NULL then case when @MinTempCardId <= tempcarditem.[TempCardId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxTempCardId Is Not NULL then case when @MaxTempCardId >= tempcarditem.[TempCardId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_TempCardId = 1
			Then case when (Select Count (*) from @MultiTable_TempCardId Where Item = tempcarditem.[TempCardId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [tempcarditem].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [tempcarditem].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = tempcarditem.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= tempcarditem.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= tempcarditem.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = tempcarditem.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = tempcarditem.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= tempcarditem.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= tempcarditem.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = tempcarditem.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By tempcarditem.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 