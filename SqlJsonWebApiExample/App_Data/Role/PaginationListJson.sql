
CREATE PROCEDURE [SpJson].[Role_PageList]
	@Skip int = 0,
	@Size int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(100) = NULL ,
@MultiText_Name nvarchar(MAX) = '' ,


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
	    Item nvarchar(100)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(100),Item) FROM dbo.SplitString(@MultiText_Name)
	
	Declare @CheckMultiTable_Name Bit = (case when LEN(@MultiText_Name) > 0 And  (select count(*) From @MultiTable_Name) > 0 then 1 Else 0 End)

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
[role].[Id] ,
[role].[Name] ,
[role].[IsDeleted] ,
[role].[ModifyDate] ,
[role].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[role_logininfo].[Id] ,
[role_logininfo].[Username] ,
[role_logininfo].[Password] ,
[role_logininfo].[UserInfoId] ,
[role_logininfo].[RoleId] ,
[role_logininfo].[IsDeleted] ,
[role_logininfo].[ModifyDate] ,
[role_logininfo].[SubmitDate]




From 
[User].[LoginInfo] as [role_logininfo]
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[RoleId] = [role].[Id]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_RoleId]

From [User].[Role] role
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = role.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= role.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= role.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = role.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([role].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([role].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [role].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [role].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = role.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= role.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= role.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = role.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = role.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= role.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= role.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = role.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By role.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 