
CREATE PROCEDURE [SpJson].[Category_ToList]
	@TopCount int = 200,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
@MultiText_Name nvarchar(MAX) = '' ,


@UpCategoryId bigint = NULL ,
@MultiText_UpCategoryId nvarchar(MAX) = '' ,
@MinUpCategoryId bigint = NULL ,
@MaxUpCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_Name TABLE(
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
	Declare @CheckMultiTable_Name Bit = (case when LEN(@MultiText_Name) > 0 And  (select count(*) From @MultiTable_Name) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_UpCategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_UpCategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_UpCategoryId)
	
	Declare @CheckMultiTable_UpCategoryId Bit = (case when LEN(@MultiText_UpCategoryId) > 0 And  (select count(*) From @MultiTable_UpCategoryId) > 0 then 1 Else 0 End)

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
[category].[Id] ,
[category].[Name] ,
[category].[UpCategoryId] ,
[category].[IsDeleted] ,
[category].[ModifyDate] ,
[category].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]

From [Shop].[Category] as category_category 
Where category_category.[Id] = category.[UpCategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_UpCategoryId]

,(Select Count(*)
From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And [category_product].[Id] = [category].[CategoryId]) 
as [Product_IdCount]
 ,
 -- End Relation 
(Select Count(*)
From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And [category_category].[Id] = [category].[UpCategoryId]) 
as [Category_IdCount]

From [Shop].[Category] category
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = category.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= category.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= category.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = category.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([category].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([category].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @UpCategoryId Is Not NULL then case when @UpCategoryId = category.[UpCategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinUpCategoryId Is Not NULL then case when @MinUpCategoryId <= category.[UpCategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxUpCategoryId Is Not NULL then case when @MaxUpCategoryId >= category.[UpCategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_UpCategoryId = 1
			Then case when (Select Count (*) from @MultiTable_UpCategoryId Where Item = category.[UpCategoryId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [category].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [category].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = category.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= category.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= category.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = category.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = category.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= category.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= category.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = category.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By category.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 