
CREATE PROCEDURE [SpJson].[FactorInfo_PageList]
	@Skip int = 0,
	@Size int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@PhoneNumber nvarchar(50) = NULL ,
@MultiText_PhoneNumber nvarchar(MAX) = '' ,


@ZipCode nvarchar(50) = NULL ,
@MultiText_ZipCode nvarchar(MAX) = '' ,


@Address1 nvarchar(150) = NULL ,
@MultiText_Address1 nvarchar(MAX) = '' ,


@Address2 nvarchar(150) = NULL ,
@MultiText_Address2 nvarchar(MAX) = '' ,


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

	DECLARE @MultiTable_PhoneNumber TABLE(
	    Item nvarchar(50)
	)
	
	INSERT INTO @MultiTable_PhoneNumber (Item)
	SELECT Convert(nvarchar(50),Item) FROM dbo.SplitString(@MultiText_PhoneNumber)
	
	Declare @CheckMultiTable_PhoneNumber Bit = (case when LEN(@MultiText_PhoneNumber) > 0 And  (select count(*) From @MultiTable_PhoneNumber) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_ZipCode TABLE(
	    Item nvarchar(50)
	)
	
	INSERT INTO @MultiTable_ZipCode (Item)
	SELECT Convert(nvarchar(50),Item) FROM dbo.SplitString(@MultiText_ZipCode)
	
	Declare @CheckMultiTable_ZipCode Bit = (case when LEN(@MultiText_ZipCode) > 0 And  (select count(*) From @MultiTable_ZipCode) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_Address1 TABLE(
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Address1 (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Address1)
	
	Declare @CheckMultiTable_Address1 Bit = (case when LEN(@MultiText_Address1) > 0 And  (select count(*) From @MultiTable_Address1) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_Address2 TABLE(
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Address2 (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Address2)
	
	Declare @CheckMultiTable_Address2 Bit = (case when LEN(@MultiText_Address2) > 0 And  (select count(*) From @MultiTable_Address2) > 0 then 1 Else 0 End)

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


Select
[factorinfo].[Id] ,
[factorinfo].[PhoneNumber] ,
[factorinfo].[ZipCode] ,
[factorinfo].[Address1] ,
[factorinfo].[Address2] ,
[factorinfo].[IsDeleted] ,
[factorinfo].[ModifyDate] ,
[factorinfo].[SubmitDate]



From [Shop].[FactorInfo] factorinfo
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = factorinfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= factorinfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= factorinfo.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = factorinfo.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @PhoneNumber Is Not NULL then case when rtrim([factorinfo].[PhoneNumber]) Like (N'%' + @PhoneNumber + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_PhoneNumber = 1
			Then case when (Select Count (*) from @MultiTable_PhoneNumber Where rtrim([factorinfo].[PhoneNumber]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @ZipCode Is Not NULL then case when rtrim([factorinfo].[ZipCode]) Like (N'%' + @ZipCode + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ZipCode = 1
			Then case when (Select Count (*) from @MultiTable_ZipCode Where rtrim([factorinfo].[ZipCode]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @Address1 Is Not NULL then case when rtrim([factorinfo].[Address1]) Like (N'%' + @Address1 + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Address1 = 1
			Then case when (Select Count (*) from @MultiTable_Address1 Where rtrim([factorinfo].[Address1]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @Address2 Is Not NULL then case when rtrim([factorinfo].[Address2]) Like (N'%' + @Address2 + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Address2 = 1
			Then case when (Select Count (*) from @MultiTable_Address2 Where rtrim([factorinfo].[Address2]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [factorinfo].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [factorinfo].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = factorinfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= factorinfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= factorinfo.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = factorinfo.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = factorinfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= factorinfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= factorinfo.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = factorinfo.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By factorinfo.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 