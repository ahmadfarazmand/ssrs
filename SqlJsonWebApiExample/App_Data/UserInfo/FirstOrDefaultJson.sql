
CREATE PROCEDURE [SpJson].[UserInfo_FirstOrDefault]
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@FirstName nvarchar(100) = NULL ,
@MultiText_FirstName nvarchar(MAX) = '' ,


@LastName nvarchar(100) = NULL ,
@MultiText_LastName nvarchar(MAX) = '' ,


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

	DECLARE @MultiTable_FirstName TABLE(
	    Item nvarchar(100)
	)
	
	INSERT INTO @MultiTable_FirstName (Item)
	SELECT Convert(nvarchar(100),Item) FROM dbo.SplitString(@MultiText_FirstName)
	
	Declare @CheckMultiTable_FirstName Bit = (case when LEN(@MultiText_FirstName) > 0 And  (select count(*) From @MultiTable_FirstName) > 0 then 1 Else 0 End)

	DECLARE @MultiTable_LastName TABLE(
	    Item nvarchar(100)
	)
	
	INSERT INTO @MultiTable_LastName (Item)
	SELECT Convert(nvarchar(100),Item) FROM dbo.SplitString(@MultiText_LastName)
	
	Declare @CheckMultiTable_LastName Bit = (case when LEN(@MultiText_LastName) > 0 And  (select count(*) From @MultiTable_LastName) > 0 then 1 Else 0 End)

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
[userinfo].[Id] ,
[userinfo].[FirstName] ,
[userinfo].[LastName] ,
[userinfo].[IsDeleted] ,
[userinfo].[ModifyDate] ,
[userinfo].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[userinfo_logininfo].[Id] ,
[userinfo_logininfo].[Username] ,
[userinfo_logininfo].[Password] ,
[userinfo_logininfo].[UserInfoId] ,
[userinfo_logininfo].[RoleId] ,
[userinfo_logininfo].[IsDeleted] ,
[userinfo_logininfo].[ModifyDate] ,
[userinfo_logininfo].[SubmitDate]




From 
[User].[LoginInfo] as [userinfo_logininfo]
Where [userinfo_logininfo].[IsDeleted] <> 1 And  [userinfo_logininfo].[Id] = [userinfo].[UserInfoId]
Order by [userinfo_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[userinfo_tempcard].[Id] ,
[userinfo_tempcard].[UserInfoId] ,
[userinfo_tempcard].[FactorId] ,
[userinfo_tempcard].[IsDeleted] ,
[userinfo_tempcard].[ModifyDate] ,
[userinfo_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [userinfo_tempcard]
Where [userinfo_tempcard].[IsDeleted] <> 1 And  [userinfo_tempcard].[Id] = [userinfo].[UserInfoId]
Order by [userinfo_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

From [User].[UserInfo] [userinfo]
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = userinfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= userinfo.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= userinfo.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = userinfo.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @FirstName Is Not NULL then case when rtrim([userinfo].[FirstName]) Like (N'%' + @FirstName + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_FirstName = 1
			Then case when (Select Count (*) from @MultiTable_FirstName Where rtrim([userinfo].[FirstName]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @LastName Is Not NULL then case when rtrim([userinfo].[LastName]) Like (N'%' + @LastName + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_LastName = 1
			Then case when (Select Count (*) from @MultiTable_LastName Where rtrim([userinfo].[LastName]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [userinfo].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [userinfo].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = userinfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= userinfo.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= userinfo.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = userinfo.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = userinfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= userinfo.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= userinfo.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = userinfo.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 


