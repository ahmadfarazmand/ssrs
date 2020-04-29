use [master]
IF NOT EXISTS 
   (
     SELECT name FROM master.dbo.sysdatabases 
     WHERE name = N'SqlJsonWebApiExample'
    )
CREATE DATABASE [SqlJsonWebApiExample]
Go
Use [SqlJsonWebApiExample]
Go 

CREATE SCHEMA [SpJson]
GO


CREATE SCHEMA [User]
GO

CREATE SCHEMA [Shop]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString] ( @stringToSplit VARCHAR(MAX) )
RETURNS
 @returnList TABLE ([Item] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(',', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
GO


-- || Create LoginInfo || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[LoginInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] nvarchar(100) ,
[Password] nvarchar(100) ,
[UserInfoId] bigint ,
[RoleId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_LoginInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create UserInfo || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[UserInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] nvarchar(100) ,
[LastName] nvarchar(100) ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create Role || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[Role](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(100) ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create Product || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[Product](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Price] float ,
[Count] int ,
[Title] nvarchar(150) ,
[OffPercent] int ,
[CategoryId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create Category || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[Category](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(150) ,
[UpCategoryId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create TempCard || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[TempCard](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserInfoId] bigint ,
[FactorId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_TempCard] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create TempCardItem || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[TempCardItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Count] int ,
[ProductId] bigint ,
[TempCardId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_TempCardItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create ShippingType || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[ShippingType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(150) ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_ShippingType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create Factor || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[Factor](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ShippingTypeId] bigint ,
[ShippingPrice] float ,
[TotalPrice] float ,
[FactorInfoId] bigint ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_Factor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


-- || Create FactorInfo || --

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Shop].[FactorInfo](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PhoneNumber] nvarchar(50) ,
[ZipCode] nvarchar(50) ,
[Address1] nvarchar(150) ,
[Address2] nvarchar(150) ,
[IsDeleted] bit ,
[ModifyDate] datetimeoffset(7) ,
[SubmitDate] datetimeoffset(7) 

 CONSTRAINT [PK_FactorInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO





ALTER TABLE [User].[LoginInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserInfoId_LoginInfo_UserInfo] FOREIGN KEY([UserInfoId])
REFERENCES [User].[UserInfo] ([Id])
GO
ALTER TABLE [User].[LoginInfo] CHECK CONSTRAINT [FK_UserInfoId_LoginInfo_UserInfo]
GO


 

ALTER TABLE [User].[LoginInfo]  WITH CHECK ADD  CONSTRAINT [FK_RoleId_LoginInfo_Role] FOREIGN KEY([RoleId])
REFERENCES [User].[Role] ([Id])
GO
ALTER TABLE [User].[LoginInfo] CHECK CONSTRAINT [FK_RoleId_LoginInfo_Role]
GO


 

ALTER TABLE [Shop].[Product]  WITH CHECK ADD  CONSTRAINT [FK_CategoryId_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [Shop].[Category] ([Id])
GO
ALTER TABLE [Shop].[Product] CHECK CONSTRAINT [FK_CategoryId_Product_Category]
GO


 

ALTER TABLE [Shop].[Category]  WITH CHECK ADD  CONSTRAINT [FK_UpCategoryId_Category_Category] FOREIGN KEY([UpCategoryId])
REFERENCES [Shop].[Category] ([Id])
GO
ALTER TABLE [Shop].[Category] CHECK CONSTRAINT [FK_UpCategoryId_Category_Category]
GO


 

ALTER TABLE [Shop].[TempCard]  WITH CHECK ADD  CONSTRAINT [FK_UserInfoId_TempCard_UserInfo] FOREIGN KEY([UserInfoId])
REFERENCES [User].[UserInfo] ([Id])
GO
ALTER TABLE [Shop].[TempCard] CHECK CONSTRAINT [FK_UserInfoId_TempCard_UserInfo]
GO


 

ALTER TABLE [Shop].[TempCard]  WITH CHECK ADD  CONSTRAINT [FK_FactorId_TempCard_Factor] FOREIGN KEY([FactorId])
REFERENCES [Shop].[Factor] ([Id])
GO
ALTER TABLE [Shop].[TempCard] CHECK CONSTRAINT [FK_FactorId_TempCard_Factor]
GO


 

ALTER TABLE [Shop].[TempCardItem]  WITH CHECK ADD  CONSTRAINT [FK_ProductId_TempCardItem_Product] FOREIGN KEY([ProductId])
REFERENCES [Shop].[Product] ([Id])
GO
ALTER TABLE [Shop].[TempCardItem] CHECK CONSTRAINT [FK_ProductId_TempCardItem_Product]
GO


 

ALTER TABLE [Shop].[TempCardItem]  WITH CHECK ADD  CONSTRAINT [FK_TempCardId_TempCardItem_TempCard] FOREIGN KEY([TempCardId])
REFERENCES [Shop].[TempCard] ([Id])
GO
ALTER TABLE [Shop].[TempCardItem] CHECK CONSTRAINT [FK_TempCardId_TempCardItem_TempCard]
GO


 

ALTER TABLE [Shop].[Factor]  WITH CHECK ADD  CONSTRAINT [FK_ShippingTypeId_Factor_ShippingType] FOREIGN KEY([ShippingTypeId])
REFERENCES [Shop].[ShippingType] ([Id])
GO
ALTER TABLE [Shop].[Factor] CHECK CONSTRAINT [FK_ShippingTypeId_Factor_ShippingType]
GO


 

ALTER TABLE [Shop].[Factor]  WITH CHECK ADD  CONSTRAINT [FK_FactorInfoId_Factor_FactorInfo] FOREIGN KEY([FactorInfoId])
REFERENCES [Shop].[FactorInfo] ([Id])
GO
ALTER TABLE [Shop].[Factor] CHECK CONSTRAINT [FK_FactorInfoId_Factor_FactorInfo]
GO


 



CREATE PROCEDURE [SpJson].[LoginInfo_FirstOrDefault]
    
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


Select Top(1)
[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]



From [User].[LoginInfo] [logininfo]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[LoginInfo_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]



From [User].[LoginInfo] [logininfo]
Where [logininfo].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[LoginInfo_ToList]
	@TopCount int = 200,
    
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


Select Top(@TopCount)
[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]



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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

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
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[LoginInfo_AddNewData]
    @Username nvarchar(100) = NULL ,
@Password nvarchar(100) = NULL ,
@UserInfoId bigint = NULL ,
@RoleId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [User].[LoginInfo]
	(Username,Password,UserInfoId,RoleId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Username,@Password,@UserInfoId,@RoleId,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

	
	
	From [User].[LoginInfo] [logininfo]
	Where 
	[logininfo].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[LoginInfo_UpdateData]
    @Id bigint = NULL ,
@Username nvarchar(100) = NULL ,
@Password nvarchar(100) = NULL ,
@UserInfoId bigint = NULL ,
@RoleId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[LoginInfo] 
Set 
[Username] = @Username, 
[Password] = @Password, 
[UserInfoId] = @UserInfoId, 
[RoleId] = @RoleId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

	
	
	From [User].[LoginInfo] [logininfo]
	Where 
	[logininfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[LoginInfo_DeleteData]
    @Id bigint
AS
Update [User].[LoginInfo] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

	
	
	From [User].[LoginInfo]
	Where 
	[logininfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[LoginInfo_RestoreData]
    @Id bigint
AS
Update [User].[LoginInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]

	
	
	From [User].[LoginInfo]
	Where 
	[logininfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[LoginInfo_AutoComplete]
	@TopCount int = 20,
    
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


Select Top(@TopCount)
[logininfo].[Id] ,
[logininfo].[Username] ,
[logininfo].[Password] ,
[logininfo].[UserInfoId] ,
[logininfo].[RoleId] ,
[logininfo].[IsDeleted] ,
[logininfo].[ModifyDate] ,
[logininfo].[SubmitDate]


From [User].[LoginInfo] logininfo
Where
logininfo.IsDeleted <> 1 And
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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[LoginInfo_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 

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



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[UserInfo_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
Where [userinfo].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[UserInfo_ToList]
	@TopCount int = 200,
    
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


Select Top(@TopCount)
[userinfo].[Id] ,
[userinfo].[FirstName] ,
[userinfo].[LastName] ,
[userinfo].[IsDeleted] ,
[userinfo].[ModifyDate] ,
[userinfo].[SubmitDate]

,
(Select Count(*)
From 
[User].[LoginInfo] as [userinfo_logininfo]
Where [userinfo_logininfo].[IsDeleted] <> 1 And [userinfo_logininfo].[Id] = [userinfo].[UserInfoId]) 
as [LoginInfo_IdCount]
 ,
 -- End Relation 
(Select Count(*)
From 
[Shop].[TempCard] as [userinfo_tempcard]
Where [userinfo_tempcard].[IsDeleted] <> 1 And [userinfo_tempcard].[Id] = [userinfo].[UserInfoId]) 
as [TempCard_IdCount]

From [User].[UserInfo] userinfo
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




Order By userinfo.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[UserInfo_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


Select
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

From [User].[UserInfo] userinfo
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




Order By userinfo.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[UserInfo_AddNewData]
    @FirstName nvarchar(100) = NULL ,
@LastName nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [User].[UserInfo]
	(FirstName,LastName,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@FirstName,@LastName,@IsDeleted,@ModifyDate,@SubmitDate)
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
	[userinfo].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[UserInfo_UpdateData]
    @Id bigint = NULL ,
@FirstName nvarchar(100) = NULL ,
@LastName nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[UserInfo] 
Set 
[FirstName] = @FirstName, 
[LastName] = @LastName, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

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
	[userinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[UserInfo_DeleteData]
    @Id bigint
AS
Update [User].[UserInfo] 
Set 
[IsDeleted] = 1
Where Id = @Id

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

	From [User].[UserInfo]
	Where 
	[userinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[UserInfo_RestoreData]
    @Id bigint
AS
Update [User].[UserInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
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

	From [User].[UserInfo]
	Where 
	[userinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[UserInfo_AutoComplete]
	@TopCount int = 20,
    
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


Select Top(@TopCount)
[userinfo].[Id] ,
[userinfo].[FirstName] ,
[userinfo].[LastName] ,
[userinfo].[IsDeleted] ,
[userinfo].[ModifyDate] ,
[userinfo].[SubmitDate]


From [User].[UserInfo] userinfo
Where
userinfo.IsDeleted <> 1 And
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




Order By userinfo.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[UserInfo_Count]
    
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



Select Count(*)
From [User].[UserInfo] userinfo
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[Role_FirstOrDefault]
    
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


Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

From [User].[Role] [role]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[Role_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

From [User].[Role] [role]
Where [role].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[Role_ToList]
	@TopCount int = 200,
    
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


Select Top(@TopCount)
[role].[Id] ,
[role].[Name] ,
[role].[IsDeleted] ,
[role].[ModifyDate] ,
[role].[SubmitDate]

,
(Select Count(*)
From 
[User].[LoginInfo] as [role_logininfo]
Where [role_logininfo].[IsDeleted] <> 1 And [role_logininfo].[Id] = [role].[RoleId]) 
as [LoginInfo_IdCount]

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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

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
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[Role_AddNewData]
    @Name nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [User].[Role]
	(Name,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Name,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

	From [User].[Role] [role]
	Where 
	[role].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[Role_UpdateData]
    @Id bigint = NULL ,
@Name nvarchar(100) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [User].[Role] 
Set 
[Name] = @Name, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

	From [User].[Role] [role]
	Where 
	[role].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Role_DeleteData]
    @Id bigint
AS
Update [User].[Role] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

	From [User].[Role]
	Where 
	[role].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Role_RestoreData]
    @Id bigint
AS
Update [User].[Role] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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
Where [role_logininfo].[IsDeleted] <> 1 And  [role_logininfo].[Id] = [role].[RoleId]
Order by [role_logininfo].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [LoginInfo_Id]

	From [User].[Role]
	Where 
	[role].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[Role_AutoComplete]
	@TopCount int = 20,
    
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


Select Top(@TopCount)
[role].[Id] ,
[role].[Name] ,
[role].[IsDeleted] ,
[role].[ModifyDate] ,
[role].[SubmitDate]


From [User].[Role] role
Where
role.IsDeleted <> 1 And
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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[Role_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[Product_FirstOrDefault]
    
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


@CategoryId bigint = NULL ,
@MultiText_CategoryId nvarchar(MAX) = '' ,
@MinCategoryId bigint = NULL ,
@MaxCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_CategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_CategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_CategoryId)
	
	Declare @CheckMultiTable_CategoryId Bit = (case when LEN(@MultiText_CategoryId) > 0 And  (select count(*) From @MultiTable_CategoryId) > 0 then 1 Else 0 End)

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
[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

From [Shop].[Product] [product]
Where 
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
		1 = (case when @CategoryId Is Not NULL then case when @CategoryId = product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCategoryId Is Not NULL then case when @MinCategoryId <= product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCategoryId Is Not NULL then case when @MaxCategoryId >= product.[CategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_CategoryId = 1
			Then case when (Select Count (*) from @MultiTable_CategoryId Where Item = product.[CategoryId]) > 0 then 1 Else 0 End
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[Product_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

From [Shop].[Product] [product]
Where [product].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[Product_ToList]
	@TopCount int = 200,
    
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


@CategoryId bigint = NULL ,
@MultiText_CategoryId nvarchar(MAX) = '' ,
@MinCategoryId bigint = NULL ,
@MaxCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_CategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_CategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_CategoryId)
	
	Declare @CheckMultiTable_CategoryId Bit = (case when LEN(@MultiText_CategoryId) > 0 And  (select count(*) From @MultiTable_CategoryId) > 0 then 1 Else 0 End)

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
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

,(Select Count(*)
From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And [product_tempcarditem].[Id] = [product].[ProductId]) 
as [TempCardItem_IdCount]

From [Shop].[Product] product
Where 
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
		1 = (case when @CategoryId Is Not NULL then case when @CategoryId = product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCategoryId Is Not NULL then case when @MinCategoryId <= product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCategoryId Is Not NULL then case when @MaxCategoryId >= product.[CategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_CategoryId = 1
			Then case when (Select Count (*) from @MultiTable_CategoryId Where Item = product.[CategoryId]) > 0 then 1 Else 0 End
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
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[Product_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


@CategoryId bigint = NULL ,
@MultiText_CategoryId nvarchar(MAX) = '' ,
@MinCategoryId bigint = NULL ,
@MaxCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_CategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_CategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_CategoryId)
	
	Declare @CheckMultiTable_CategoryId Bit = (case when LEN(@MultiText_CategoryId) > 0 And  (select count(*) From @MultiTable_CategoryId) > 0 then 1 Else 0 End)

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
[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

From [Shop].[Product] product
Where 
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
		1 = (case when @CategoryId Is Not NULL then case when @CategoryId = product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCategoryId Is Not NULL then case when @MinCategoryId <= product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCategoryId Is Not NULL then case when @MaxCategoryId >= product.[CategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_CategoryId = 1
			Then case when (Select Count (*) from @MultiTable_CategoryId Where Item = product.[CategoryId]) > 0 then 1 Else 0 End
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
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[Product_AddNewData]
    @Price float = NULL ,
@Count int = NULL ,
@Title nvarchar(150) = NULL ,
@OffPercent int = NULL ,
@CategoryId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[Product]
	(Price,Count,Title,OffPercent,CategoryId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Price,@Count,@Title,@OffPercent,@CategoryId,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

	,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

	From [Shop].[Product] [product]
	Where 
	[product].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[Product_UpdateData]
    @Id bigint = NULL ,
@Price float = NULL ,
@Count int = NULL ,
@Title nvarchar(150) = NULL ,
@OffPercent int = NULL ,
@CategoryId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[Product] 
Set 
[Price] = @Price, 
[Count] = @Count, 
[Title] = @Title, 
[OffPercent] = @OffPercent, 
[CategoryId] = @CategoryId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

	,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

	From [Shop].[Product] [product]
	Where 
	[product].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Product_DeleteData]
    @Id bigint
AS
Update [Shop].[Product] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

	,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

	From [Shop].[Product]
	Where 
	[product].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Product_RestoreData]
    @Id bigint
AS
Update [Shop].[Product] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[product].[Id] ,
[product].[Price] ,
[product].[Count] ,
[product].[Title] ,
[product].[OffPercent] ,
[product].[CategoryId] ,
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

	,(JSON_QUERY((
Select Top(1) 
[product_category].[Id] ,
[product_category].[Name] ,
[product_category].[UpCategoryId] ,
[product_category].[IsDeleted] ,
[product_category].[ModifyDate] ,
[product_category].[SubmitDate]

From [Shop].[Category] as product_category 
Where product_category.[Id] = product.[CategoryId] For Json PATH,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
)))
as [Category_CategoryId]

	,(JSON_QUERY(
(Select Top(30)

[product_tempcarditem].[Id] ,
[product_tempcarditem].[Count] ,
[product_tempcarditem].[ProductId] ,
[product_tempcarditem].[TempCardId] ,
[product_tempcarditem].[IsDeleted] ,
[product_tempcarditem].[ModifyDate] ,
[product_tempcarditem].[SubmitDate]




From 
[Shop].[TempCardItem] as [product_tempcarditem]
Where [product_tempcarditem].[IsDeleted] <> 1 And  [product_tempcarditem].[Id] = [product].[ProductId]
Order by [product_tempcarditem].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCardItem_Id]

	From [Shop].[Product]
	Where 
	[product].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

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


@CategoryId bigint = NULL ,
@MultiText_CategoryId nvarchar(MAX) = '' ,
@MinCategoryId bigint = NULL ,
@MaxCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_CategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_CategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_CategoryId)
	
	Declare @CheckMultiTable_CategoryId Bit = (case when LEN(@MultiText_CategoryId) > 0 And  (select count(*) From @MultiTable_CategoryId) > 0 then 1 Else 0 End)

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
[product].[CategoryId] ,
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
		1 = (case when @CategoryId Is Not NULL then case when @CategoryId = product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCategoryId Is Not NULL then case when @MinCategoryId <= product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCategoryId Is Not NULL then case when @MaxCategoryId >= product.[CategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_CategoryId = 1
			Then case when (Select Count (*) from @MultiTable_CategoryId Where Item = product.[CategoryId]) > 0 then 1 Else 0 End
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
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[Product_Count]
    
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


@CategoryId bigint = NULL ,
@MultiText_CategoryId nvarchar(MAX) = '' ,
@MinCategoryId bigint = NULL ,
@MaxCategoryId bigint = NULL ,


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

	DECLARE @MultiTable_CategoryId TABLE(
	    Item bigint
	)
	
	INSERT INTO @MultiTable_CategoryId (Item)
	SELECT Convert(bigint,Item) FROM dbo.SplitString(@MultiText_CategoryId)
	
	Declare @CheckMultiTable_CategoryId Bit = (case when LEN(@MultiText_CategoryId) > 0 And  (select count(*) From @MultiTable_CategoryId) > 0 then 1 Else 0 End)

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



Select Count(*)
From [Shop].[Product] product
Where
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
		1 = (case when @CategoryId Is Not NULL then case when @CategoryId = product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MinCategoryId Is Not NULL then case when @MinCategoryId <= product.[CategoryId] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxCategoryId Is Not NULL then case when @MaxCategoryId >= product.[CategoryId] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_CategoryId = 1
			Then case when (Select Count (*) from @MultiTable_CategoryId Where Item = product.[CategoryId]) > 0 then 1 Else 0 End
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[Category_FirstOrDefault]
    
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


Select Top(1)
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

,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

From [Shop].[Category] [category]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[Category_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
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

,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

From [Shop].[Category] [category]
Where [category].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

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
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[Category_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


Select
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

,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

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
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[Category_AddNewData]
    @Name nvarchar(150) = NULL ,
@UpCategoryId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[Category]
	(Name,UpCategoryId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Name,@UpCategoryId,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

	From [Shop].[Category] [category]
	Where 
	[category].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[Category_UpdateData]
    @Id bigint = NULL ,
@Name nvarchar(150) = NULL ,
@UpCategoryId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[Category] 
Set 
[Name] = @Name, 
[UpCategoryId] = @UpCategoryId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

	From [Shop].[Category] [category]
	Where 
	[category].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Category_DeleteData]
    @Id bigint
AS
Update [Shop].[Category] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

	From [Shop].[Category]
	Where 
	[category].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Category_RestoreData]
    @Id bigint
AS
Update [Shop].[Category] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[category_product].[Id] ,
[category_product].[Price] ,
[category_product].[Count] ,
[category_product].[Title] ,
[category_product].[OffPercent] ,
[category_product].[CategoryId] ,
[category_product].[IsDeleted] ,
[category_product].[ModifyDate] ,
[category_product].[SubmitDate]




From 
[Shop].[Product] as [category_product]
Where [category_product].[IsDeleted] <> 1 And  [category_product].[Id] = [category].[CategoryId]
Order by [category_product].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Product_Id]
 ,
 -- End Relation 
(JSON_QUERY(
(Select Top(30)

[category_category].[Id] ,
[category_category].[Name] ,
[category_category].[UpCategoryId] ,
[category_category].[IsDeleted] ,
[category_category].[ModifyDate] ,
[category_category].[SubmitDate]




From 
[Shop].[Category] as [category_category]
Where [category_category].[IsDeleted] <> 1 And  [category_category].[Id] = [category].[UpCategoryId]
Order by [category_category].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Category_Id]

	From [Shop].[Category]
	Where 
	[category].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[Category_AutoComplete]
	@TopCount int = 20,
    
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


From [Shop].[Category] category
Where
category.IsDeleted <> 1 And
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
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[Category_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 

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



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[TempCard_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
Where [tempcard].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[TempCard_ToList]
	@TopCount int = 200,
    
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


Select Top(@TopCount)
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

,(Select Count(*)
From 
[Shop].[TempCardItem] as [tempcard_tempcarditem]
Where [tempcard_tempcarditem].[IsDeleted] <> 1 And [tempcard_tempcarditem].[Id] = [tempcard].[TempCardId]) 
as [TempCardItem_IdCount]

From [Shop].[TempCard] tempcard
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




Order By tempcard.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[TempCard_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


Select
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

From [Shop].[TempCard] tempcard
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




Order By tempcard.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[TempCard_AddNewData]
    @UserInfoId bigint = NULL ,
@FactorId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[TempCard]
	(UserInfoId,FactorId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@UserInfoId,@FactorId,@IsDeleted,@ModifyDate,@SubmitDate)
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
	[tempcard].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[TempCard_UpdateData]
    @Id bigint = NULL ,
@UserInfoId bigint = NULL ,
@FactorId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[TempCard] 
Set 
[UserInfoId] = @UserInfoId, 
[FactorId] = @FactorId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

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
	[tempcard].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[TempCard_DeleteData]
    @Id bigint
AS
Update [Shop].[TempCard] 
Set 
[IsDeleted] = 1
Where Id = @Id

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

	From [Shop].[TempCard]
	Where 
	[tempcard].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[TempCard_RestoreData]
    @Id bigint
AS
Update [Shop].[TempCard] 
Set 
[IsDeleted] = 0
Where Id = @Id
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

	From [Shop].[TempCard]
	Where 
	[tempcard].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[TempCard_AutoComplete]
	@TopCount int = 20,
    
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


Select Top(@TopCount)
[tempcard].[Id] ,
[tempcard].[UserInfoId] ,
[tempcard].[FactorId] ,
[tempcard].[IsDeleted] ,
[tempcard].[ModifyDate] ,
[tempcard].[SubmitDate]


From [Shop].[TempCard] tempcard
Where
tempcard.IsDeleted <> 1 And
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




Order By tempcard.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[TempCard_Count]
    
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



Select Count(*)
From [Shop].[TempCard] tempcard
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_FirstOrDefault]
    
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


Select Top(1)
[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]



From [Shop].[TempCardItem] [tempcarditem]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]



From [Shop].[TempCardItem] [tempcarditem]
Where [tempcarditem].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

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
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


Select
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
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_AddNewData]
    @Count int = NULL ,
@ProductId bigint = NULL ,
@TempCardId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[TempCardItem]
	(Count,ProductId,TempCardId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Count,@ProductId,@TempCardId,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]

	
	
	From [Shop].[TempCardItem] [tempcarditem]
	Where 
	[tempcarditem].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[TempCardItem_UpdateData]
    @Id bigint = NULL ,
@Count int = NULL ,
@ProductId bigint = NULL ,
@TempCardId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[TempCardItem] 
Set 
[Count] = @Count, 
[ProductId] = @ProductId, 
[TempCardId] = @TempCardId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]

	
	
	From [Shop].[TempCardItem] [tempcarditem]
	Where 
	[tempcarditem].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[TempCardItem_DeleteData]
    @Id bigint
AS
Update [Shop].[TempCardItem] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]

	
	
	From [Shop].[TempCardItem]
	Where 
	[tempcarditem].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[TempCardItem_RestoreData]
    @Id bigint
AS
Update [Shop].[TempCardItem] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[tempcarditem].[Id] ,
[tempcarditem].[Count] ,
[tempcarditem].[ProductId] ,
[tempcarditem].[TempCardId] ,
[tempcarditem].[IsDeleted] ,
[tempcarditem].[ModifyDate] ,
[tempcarditem].[SubmitDate]

	
	
	From [Shop].[TempCardItem]
	Where 
	[tempcarditem].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_AutoComplete]
	@TopCount int = 20,
    
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
tempcarditem.IsDeleted <> 1 And
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
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[TempCardItem_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[ShippingType_FirstOrDefault]
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
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
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
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


Select Top(1)
[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

From [Shop].[ShippingType] [shippingtype]
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= shippingtype.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = shippingtype.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([shippingtype].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([shippingtype].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [shippingtype].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [shippingtype].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = shippingtype.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = shippingtype.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[ShippingType_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

From [Shop].[ShippingType] [shippingtype]
Where [shippingtype].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[ShippingType_ToList]
	@TopCount int = 200,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
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
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
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


Select Top(@TopCount)
[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

,
(Select Count(*)
From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]) 
as [Factor_IdCount]

From [Shop].[ShippingType] shippingtype
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= shippingtype.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = shippingtype.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([shippingtype].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([shippingtype].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [shippingtype].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [shippingtype].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = shippingtype.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = shippingtype.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By shippingtype.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[ShippingType_PageList]
	@Skip int = 0,
	@Size int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
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
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
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
[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

,
(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

From [Shop].[ShippingType] shippingtype
Where 
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= shippingtype.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = shippingtype.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([shippingtype].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([shippingtype].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [shippingtype].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [shippingtype].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = shippingtype.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = shippingtype.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By shippingtype.Id Desc
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[ShippingType_AddNewData]
    @Name nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[ShippingType]
	(Name,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@Name,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[ShippingType] [shippingtype]
	Where 
	[shippingtype].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[ShippingType_UpdateData]
    @Id bigint = NULL ,
@Name nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[ShippingType] 
Set 
[Name] = @Name, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[ShippingType] [shippingtype]
	Where 
	[shippingtype].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[ShippingType_DeleteData]
    @Id bigint
AS
Update [Shop].[ShippingType] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[ShippingType]
	Where 
	[shippingtype].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[ShippingType_RestoreData]
    @Id bigint
AS
Update [Shop].[ShippingType] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
	[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]

	,
	(JSON_QUERY(
(Select Top(30)

[shippingtype_factor].[Id] ,
[shippingtype_factor].[ShippingTypeId] ,
[shippingtype_factor].[ShippingPrice] ,
[shippingtype_factor].[TotalPrice] ,
[shippingtype_factor].[FactorInfoId] ,
[shippingtype_factor].[IsDeleted] ,
[shippingtype_factor].[ModifyDate] ,
[shippingtype_factor].[SubmitDate]




From 
[Shop].[Factor] as [shippingtype_factor]
Where [shippingtype_factor].[IsDeleted] <> 1 And  [shippingtype_factor].[Id] = [shippingtype].[ShippingTypeId]
Order by [shippingtype_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[ShippingType]
	Where 
	[shippingtype].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[ShippingType_AutoComplete]
	@TopCount int = 20,
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
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
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
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


Select Top(@TopCount)
[shippingtype].[Id] ,
[shippingtype].[Name] ,
[shippingtype].[IsDeleted] ,
[shippingtype].[ModifyDate] ,
[shippingtype].[SubmitDate]


From [Shop].[ShippingType] shippingtype
Where
shippingtype.IsDeleted <> 1 And
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= shippingtype.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = shippingtype.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([shippingtype].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([shippingtype].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [shippingtype].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [shippingtype].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = shippingtype.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = shippingtype.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




Order By shippingtype.Id Desc
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[ShippingType_Count]
    
@Id bigint = NULL ,
@MultiText_Id nvarchar(MAX) = '' ,
@MinId bigint = NULL ,
@MaxId bigint = NULL ,


@Name nvarchar(150) = NULL ,
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
	    Item nvarchar(150)
	)
	
	INSERT INTO @MultiTable_Name (Item)
	SELECT Convert(nvarchar(150),Item) FROM dbo.SplitString(@MultiText_Name)
	
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



Select Count(*)
From [Shop].[ShippingType] shippingtype
Where
-- || Conditions || -- 
-- || Auto Generated Conditions || --
		1 = (case when @Id Is Not NULL then case when @Id = shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MinId Is Not NULL then case when @MinId <= shippingtype.[Id] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxId Is Not NULL then case when @MaxId >= shippingtype.[Id] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Id = 1
			Then case when (Select Count (*) from @MultiTable_Id Where Item = shippingtype.[Id]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @Name Is Not NULL then case when rtrim([shippingtype].[Name]) Like (N'%' + @Name + '%') then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_Name = 1
			Then case when (Select Count (*) from @MultiTable_Name Where rtrim([shippingtype].[Name]) Like (N'%' + Item + '%')) > 0 then 1 Else 0 End
			Else 1 End
		  ) And


-- || Auto Generated Conditions || --
		1 = (case when @IsDeleted Is Not NULL then case when @IsDeleted = [shippingtype].[IsDeleted] then 1 else 0 end  else 1 end) And
		1 = 
		  (
			case when 
			@CheckMultiTable_IsDeleted = 1
			Then case when (Select Count (*) from @MultiTable_IsDeleted Where Item = [shippingtype].[IsDeleted]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @ModifyDate Is Not NULL then case when @ModifyDate = shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinModifyDate Is Not NULL then case when @MinModifyDate <= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxModifyDate Is Not NULL then case when @MaxModifyDate >= shippingtype.[ModifyDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_ModifyDate = 1
			Then case when (Select Count (*) from @MultiTable_ModifyDate Where Item = shippingtype.[ModifyDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) And



-- || Auto Generated Conditions || --
		1 = (case when @SubmitDate Is Not NULL then case when @SubmitDate = shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MinSubmitDate Is Not NULL then case when @MinSubmitDate <= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) And
		1 = (case when @MaxSubmitDate Is Not NULL then case when @MaxSubmitDate >= shippingtype.[SubmitDate] then 1 else 0 end  else 1 end) AND
		1 = 
		  (
			case when 
			@CheckMultiTable_SubmitDate = 1
			Then case when (Select Count (*) from @MultiTable_SubmitDate Where Item = shippingtype.[SubmitDate]) > 0 then 1 Else 0 End
			Else 1 End
		  ) 




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[Factor_FirstOrDefault]
    
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


Select Top(1)
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

,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

From [Shop].[Factor] [factor]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[Factor_FirstOrDefaultById]
    @Id bigint = Null
AS   

With DataForJson
As
(
(


Select Top(1)
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

,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

From [Shop].[Factor] [factor]
Where [factor].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

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
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And [factor_tempcard].[Id] = [factor].[FactorId]) 
as [TempCard_IdCount]

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
 -- || End SelectListData || -- 

CREATE PROCEDURE [SpJson].[Factor_PageList]
	@Skip int = 0,
	@Size int = 20,
    
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


Select
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

,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

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
OFFSET  @Skip ROWS 
FETCH NEXT @Size ROWS ONLY
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[Factor_AddNewData]
    @ShippingTypeId bigint = NULL ,
@ShippingPrice float = NULL ,
@TotalPrice float = NULL ,
@FactorInfoId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[Factor]
	(ShippingTypeId,ShippingPrice,TotalPrice,FactorInfoId,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@ShippingTypeId,@ShippingPrice,@TotalPrice,@FactorInfoId,@IsDeleted,@ModifyDate,@SubmitDate)
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

	From [Shop].[Factor] [factor]
	Where 
	[factor].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
Go
CREATE PROCEDURE [SpJson].[Factor_UpdateData]
    @Id bigint = NULL ,
@ShippingTypeId bigint = NULL ,
@ShippingPrice float = NULL ,
@TotalPrice float = NULL ,
@FactorInfoId bigint = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  

Update [Shop].[Factor] 
Set 
[ShippingTypeId] = @ShippingTypeId, 
[ShippingPrice] = @ShippingPrice, 
[TotalPrice] = @TotalPrice, 
[FactorInfoId] = @FactorInfoId, 
[IsDeleted] = @IsDeleted, 
[ModifyDate] = @ModifyDate 
 

Where IsDeleted <> 1 And  Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

	From [Shop].[Factor] [factor]
	Where 
	[factor].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Factor_DeleteData]
    @Id bigint
AS
Update [Shop].[Factor] 
Set 
[IsDeleted] = 1
Where Id = @Id

;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

	From [Shop].[Factor]
	Where 
	[factor].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[Factor_RestoreData]
    @Id bigint
AS
Update [Shop].[Factor] 
Set 
[IsDeleted] = 0
Where Id = @Id
;
	With DataForJson
	As
	(
	(
	
	Select Top(1)
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

	,(JSON_QUERY(
(Select Top(30)

[factor_tempcard].[Id] ,
[factor_tempcard].[UserInfoId] ,
[factor_tempcard].[FactorId] ,
[factor_tempcard].[IsDeleted] ,
[factor_tempcard].[ModifyDate] ,
[factor_tempcard].[SubmitDate]




From 
[Shop].[TempCard] as [factor_tempcard]
Where [factor_tempcard].[IsDeleted] <> 1 And  [factor_tempcard].[Id] = [factor].[FactorId]
Order by [factor_tempcard].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [TempCard_Id]

	From [Shop].[Factor]
	Where 
	[factor].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[Factor_AutoComplete]
	@TopCount int = 20,
    
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


From [Shop].[Factor] factor
Where
factor.IsDeleted <> 1 And
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
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[Factor_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_FirstOrDefault]
    
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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

From [Shop].[FactorInfo] [factorinfo]
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




)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 



 -- || End SelectSingleData || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_FirstOrDefaultById]
    @Id bigint = Null
AS   

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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

From [Shop].[FactorInfo] [factorinfo]
Where [factorinfo].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 

 -- || End SelectByIdData || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_ToList]
	@TopCount int = 200,
    
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


Select Top(@TopCount)
[factorinfo].[Id] ,
[factorinfo].[PhoneNumber] ,
[factorinfo].[ZipCode] ,
[factorinfo].[Address1] ,
[factorinfo].[Address2] ,
[factorinfo].[IsDeleted] ,
[factorinfo].[ModifyDate] ,
[factorinfo].[SubmitDate]

,
(Select Count(*)
From 
[Shop].[Factor] as [factorinfo_factor]
Where [factorinfo_factor].[IsDeleted] <> 1 And [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]) 
as [Factor_IdCount]

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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectListData || -- 

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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

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
 -- || End SelectPaginationData || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_AddNewData]
    @PhoneNumber nvarchar(50) = NULL ,
@ZipCode nvarchar(50) = NULL ,
@Address1 nvarchar(150) = NULL ,
@Address2 nvarchar(150) = NULL ,
@IsDeleted bit = NULL ,
@ModifyDate datetimeoffset(7) = NULL ,
@SubmitDate datetimeoffset(7) = NULL

AS

BEGIN TRY  
     INSERT INTO [Shop].[FactorInfo]
	(PhoneNumber,ZipCode,Address1,Address2,IsDeleted,ModifyDate,SubmitDate) 
	VALUES 
	(@PhoneNumber,@ZipCode,@Address1,@Address2,@IsDeleted,@ModifyDate,@SubmitDate)
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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[FactorInfo] [factorinfo]
	Where 
	[factorinfo].Id = SCOPE_IDENTITY()
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
	     
END TRY  
BEGIN CATCH

Declare @ErrorJson nvarchar(MAX) = '{"Message":"' + ERROR_MESSAGE() + '","Status":false}'
Select @ErrorJson
END CATCH  






 -- || End AddSingleData || -- 
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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

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






 -- || End UpdateSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[FactorInfo_DeleteData]
    @Id bigint
AS
Update [Shop].[FactorInfo] 
Set 
[IsDeleted] = 1
Where Id = @Id

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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[FactorInfo]
	Where 
	[factorinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End DeleteSingleData || -- 

Go
CREATE PROCEDURE [SpJson].[FactorInfo_RestoreData]
    @Id bigint
AS
Update [Shop].[FactorInfo] 
Set 
[IsDeleted] = 0
Where Id = @Id
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
Where [factorinfo_factor].[IsDeleted] <> 1 And  [factorinfo_factor].[Id] = [factorinfo].[FactorInfoId]
Order by [factorinfo_factor].Id desc
 For Json PATH,INCLUDE_NULL_VALUES) 
)) 
as [Factor_Id]

	From [Shop].[FactorInfo]
	Where 
	[factorinfo].Id = @Id
	)
	)
	
	Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER

GO 

 -- || End RestoreSingleData || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_AutoComplete]
	@TopCount int = 20,
    
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


Select Top(@TopCount)
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
factorinfo.IsDeleted <> 1 And
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
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES
    
GO 
 -- || End SelectAutoComplete || -- 

CREATE PROCEDURE [SpJson].[FactorInfo_Count]
    
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



Select Count(*)
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




    
GO 
 -- || End SelectCount || -- 
