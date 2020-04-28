
CREATE PROCEDURE [SpJson].[LoginInfo_PageList]
	@Skip int = 0,
	@Size int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Username nvarchar(100) = NULL ,
@MultiText_Username nvarchar(MAX) = '' ,


@Password nvarchar(100) = NULL ,
@MultiText_Password nvarchar(MAX) = '' ,


@UserInfoId bigint = NULL ,
@MultiText_UserInfoId nvarchar(MAX) = '' ,
@MinUserInfoId bigint = NULL ,
@MaxUserInfoId bigint = NULL ,


@RoleId bigint = NULL ,
@MultiText_RoleId nvarchar(MAX) = '' ,
@MinRoleId bigint = NULL ,
@MaxRoleId bigint = NULL ,


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

	DECLARE @MultiTable_Username TABLE(
	    Item nvarchar(100)
	)
	
	INSERT INTO @MultiTable_Username (Item)
	SELECT Convert(nvarchar(100),Item) FROM dbo.SplitString(@MultiText_Username)
	
	Declare @CheckMultiTable_Username Bit = (case when LEN(@MultiText_Username) > 0 And  (select count(*) From @MultiTable_Username) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_Password TABLE(
	    Item nvarchar(100)
	)
	
	INSERT INTO @MultiTable_Password (Item)
	SELECT Convert(nvarchar(100),Item) FROM dbo.SplitString(@MultiText_Password)
	
	Declare @CheckMultiTable_Password Bit = (case when LEN(@MultiText_Password) > 0 And  (select count(*) From @MultiTable_Password) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_UserInfoId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_UserInfoId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_UserInfoId)
	
	Declare @CheckMultiTable_UserInfoId Bit = (case when LEN(@MultiText_UserInfoId) > 0 And  (select count(*) From @MultiTable_UserInfoId) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_RoleId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_RoleId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_RoleId)
	
	Declare @CheckMultiTable_RoleId Bit = (case when LEN(@MultiText_RoleId) > 0 And  (select count(*) From @MultiTable_RoleId) > 0 then 1 Else 0 End)

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
[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[logininfo_userinfo].[Id] ,
[logininfo_userinfo].[FirstName] ,
[logininfo_userinfo].[LastName] ,
[logininfo_userinfo].[IsDeleted] ,
[logininfo_userinfo].[ModifyDate] ,
[logininfo_userinfo].[SubmitDate]




From 
[User].[UserInfo] as [logininfo_userinfo]
Where [logininfo_userinfo].[IsDeleted] <> 1 And  [logininfo_userinfo].[Id] = [logininfo].[UserInfoId]
Order by [logininfo_userinfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [UserInfo_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[logininfo_role].[Id] ,
[logininfo_role].[Name] ,
[logininfo_role].[IsDeleted] ,
[logininfo_role].[ModifyDate] ,
[logininfo_role].[SubmitDate]




From 
[User].[Role] as [logininfo_role]
Where [logininfo_role].[IsDeleted] <> 1 And  [logininfo_role].[Id] = [logininfo].[RoleId]
Order by [logininfo_role].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Role_Id]

From [User].[LoginInfo] logininfo
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = logininfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= logininfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= logininfo.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = logininfo.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Username Is Not NULL then case when rtrim([logininfo].[Username]) Like (N'%' + @Username + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Username = 1
			Then case when (Select Count (*) from @MultiTable_Username Where rtrim([logininfo].[Username]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @Password Is Not NULL then case when rtrim([logininfo].[Password]) Like (N'%' + @Password + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Password = 1
			Then case when (Select Count (*) from @MultiTable_Password Where rtrim([logininfo].[Password]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @UserInfoId Is Not NULL then case when @UserInfoId = logininfo.[UserInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinUserInfoId Is Not NULL then case when @MinUserInfoId <= logininfo.[UserInfoId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxUserInfoId Is Not NULL then case when @MaxUserInfoId >= logininfo.[UserInfoId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_UserInfoId = 1
			Then case when (Select Count (*) from @MultiTable_UserInfoId Where Item = logininfo.[UserInfoId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @RoleId Is Not NULL then case when @RoleId = logininfo.[RoleId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinRoleId Is Not NULL then case when @MinRoleId <= logininfo.[RoleId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxRoleId Is Not NULL then case when @MaxRoleId >= logininfo.[RoleId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_RoleId = 1
			Then case when (Select Count (*) from @MultiTable_RoleId Where Item = logininfo.[RoleId]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [logininfo].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [logininfo].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = logininfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= logininfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= logininfo.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = logininfo.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = logininfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= logininfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= logininfo.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = logininfo.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By logininfo.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 