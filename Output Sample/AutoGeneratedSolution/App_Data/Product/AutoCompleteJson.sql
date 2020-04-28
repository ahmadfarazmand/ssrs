
CREATE PROCEDURE [SpJson].[Product_AutoComplete]
	@TopCount int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Price float = NULL ,
@MultiText_Price nvarchar(MAX) = '' ,
@MinPrice float = NULL ,
@MaxPrice float = NULL ,


@Count int = NULL ,
@MultiText_Count nvarchar(MAX) = '' ,
@MinCount int = NULL ,
@MaxCount int = NULL ,


@Title nvarchar(150) = NULL ,
@MultiText_Title nvarchar(MAX) = '' ,


@OffPercent int = NULL ,
@MultiText_OffPercent nvarchar(MAX) = '' ,
@MinOffPercent int = NULL ,
@MaxOffPercent int = NULL ,


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

	DECLARE @MultiTable_Price TABLE(
	    Item float
	)
	
	INSERT INTO @MultiTable_Price (Item)
	SELECT Convert(float,Item) FROM dbo.SplitString(@MultiText_Price)
	
	Declare @CheckMultiTable_Price Bit = (case when LEN(@MultiText_Price) > 0 And  (select count(*) From @MultiTable_Price) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_Count TABLE(
	    Item int
	)
	
	INSERT INTO @MultiTable_Count (Item)
	SELECT Convert(int,Item) FROM dbo.SplitString(@MultiText_Count)
	
	Declare @CheckMultiTable_Count Bit = (case when LEN(@MultiText_Count) > 0 And  (select count(*) From @MultiTable_Count) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_Title TABLE(
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Title (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Title)
	
	Declare @CheckMultiTable_Title Bit = (case when LEN(@MultiText_Title) > 0 And  (select count(*) From @MultiTable_Title) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_OffPercent TABLE(
	    Item int
	)
	
	INSERT INTO @MultiTable_OffPercent (Item)
	SELECT Convert(int,Item) FROM dbo.SplitString(@MultiText_OffPercent)
	
	Declare @CheckMultiTable_OffPercent Bit = (case when LEN(@MultiText_OffPercent) > 0 And  (select count(*) From @MultiTable_OffPercent) > 0 then 1 Else 0 End)

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
[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]


From [Shop].[Product] product
Where
product.IsDeleted <> 1 And
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = product.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= product.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= product.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = product.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Price Is Not NULL then case when @Price = product.[Price] then 1 else 0 end  else 1 end) And
		1 = (case when @MinPrice Is Not NULL then case when @MinPrice <= product.[Price] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxPrice Is Not NULL then case when @MaxPrice >= product.[Price] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Price = 1
			Then case when (Select Count (*) from @MultiTable_Price Where Item = product.[Price]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Count Is Not NULL then case when @Count = product.[Count] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCount Is Not NULL then case when @MinCount <= product.[Count] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCount Is Not NULL then case when @MaxCount >= product.[Count] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Count = 1
			Then case when (Select Count (*) from @MultiTable_Count Where Item = product.[Count]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Title Is Not NULL then case when rtrim([product].[Title]) Like (N'%' + @Title + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Title = 1
			Then case when (Select Count (*) from @MultiTable_Title Where rtrim([product].[Title]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @OffPercent Is Not NULL then case when @OffPercent = product.[OffPercent] then 1 else 0 end  else 1 end) And
		1 = (case when @MinOffPercent Is Not NULL then case when @MinOffPercent <= product.[OffPercent] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxOffPercent Is Not NULL then case when @MaxOffPercent >= product.[OffPercent] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_OffPercent = 1
			Then case when (Select Count (*) from @MultiTable_OffPercent Where Item = product.[OffPercent]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [product].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [product].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = product.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= product.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= product.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = product.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = product.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= product.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= product.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = product.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By product.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 