Go
CREATE PROCEDURE [SpJson].[Product_UpdateData]
    @Id bigint = NULL ,
@Price float = NULL ,
@Count int = NULL ,
@Title nvarchar(150) = NULL ,
@OffPercent int = NULL ,
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
[product].[IsDeleted] ,
[product].[ModifyDate] ,
[product].[SubmitDate]

	
	
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





