# SQL Server REST Scaffolding
SSRS is a code generation framework for ASP.NET Web API based on SQL Server JSON result and c# repository pattern manager.
**The best feature that can be used for this scaffolding is the removal of Entity Framework and the removal of Auto Mapper in the development of the REST projects**
In my projects, I always implement the project scaffold with SQL in this way, and then I change the data based on more complex conditions or update and edit operations based on the parameters of the final design. With JSON SQL, I don't need to create output models for slow methods like Auto Mapper and EF.

**I shared my code generator demo version. Create a REST for your database in short time by designing the database you want according to the intended framework in SSRS user interface. 10 SQL table available for free code generation each 10 days.**
Download sample output solution or download SSRS exe project and start create your REST in a few minutes.


### SQL Server Auto Generate Output Results:
1.	Generate script for designed tables and relations
2.	SQL Server Stored Procedures with JSON results (10 SP for each table)
3.	Auto generate conditions and parameters in all store procedures
4.	All search parameters with multi search types for each property in all select stored procedures for each table
5.	All search conditions by data types for all search parameters
6.	Include Insert, Update, Delete and Restore SP for each table
7.	Include JSON object in one-one relations 
8.	Include Select Top (30) JSON array for one-many relations
9.	Include Select Count (*) INT for one-many relations in Top (n) select search stored procedures
10.	Include Select Offset Fetch for pagination search type stored procedures
11.	Select Top (1) store procedures with all parameters or just by id
And …
### Visual Studio 2015 ASP.NET Web API Solution Output Results:
1.	Interface classes to integrate any type of store procedure JSON output into controllers using by repository pattern
2.	Generate all API controllers inherited from base API controller in project (asynchronous methods)
3.	Generate SQL Server repository manager class used in all controllers
4.	Generate all repository classes for SQL manager and their all methods for each table (asynchronous methods)
5.	Generate 5 model type for each table like: Insert, Update, Filter, Search and Pagination
6.	Include jwtAuth for controllers
7.	Generate permission class for jwtAuth
And …



### Output || Sample Project Usage:
1.	Open solution
2.	Rebuild solution to restoring NUGET packages
3.	Execute App_Data\DataBase.sql in SQL Server 2016+
4.	Set connection string in web.config
5.	Press F5

### SSRS Framework:
To integrate SQL and ASP.Net outputs, there are defaults in the user interface that you can use to scaffold your REST. Check if your requirements are within this framework

### Tables:
Default tables (Role, LoginInfo and UserInfo):
There are three default tables for creating a user, and a default SP for the user's login is available in the project according to these tables. Your other tables can have foreign keys from these tables. 
Default properties (Id, IsDeleted, SubmitDate, ModifyDate):
This properties are always included in any table and have interfaces in c# code generated and models
1.	Id: identity for each table with BIGINT data type
2.	IsDeleted: bit data type to use delete or restore each row
3.	SubmitDate: datetimeoffset data type when a row is created managed in c# 
4.	MofiyDate: datetimeoffset data type when a row is updated managed in c#

### Store Procedures:
Auto generated store procedures with different return results 
**Names and returns:**
1.	ToList : relational values top count select order by desc JSON array (multiple filter and conditions)
2.	PageList: relational values offset fetch order by desc JSON array (multiple filter and conditions)
3.	AutoComplete: no relation values top count list order by desc JSON array used for auto complete form searches (multiple filter and conditions)
4.	FirstOrDefault: relational top one select order by desc JSON object (multiple filter and conditions)
5.	FirstOrDefaultById: relational top one select order by desc JSON object just id condition 
6.	Count: Select Count(*) (multiple filter and conditions)
7.	AddNewData : Insert and return inserted data as JSON object
8.	UpdateData : update and return relational select for updated row as JSON object
9.	Delete : update IsDeleted property set true and return deleted row as JSON object
10.	Restore: update IsDeleted property set false and return restored row as JSON array
### C# Repository Pattern:
Generated methods and models are working with repository based on JSON results. Models generated to create SQL repositories and create interfaces based on SP names.












