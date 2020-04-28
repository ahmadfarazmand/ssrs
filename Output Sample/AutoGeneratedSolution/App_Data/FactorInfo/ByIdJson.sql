
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



From [Shop].[FactorInfo] [factorinfo]
Where [factorinfo].[Id] = @Id
)
)

Select * From DataForJson FOR JSON AUTO,INCLUDE_NULL_VALUES,WITHOUT_ARRAY_WRAPPER
    
GO 
