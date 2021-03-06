using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SqlJsonWebApiExample
{
    public static class RolePermission
    {
        public const string Admin = "admin";
        public static IEnumerable<RoleControllerModel> RoleList
        {
            get
            {
                var result = new List<RoleControllerModel>();

                result.Add(new RoleControllerModel()
                {
                    Name = "Values",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "Token", Roles = new string[] { Admin } },
                        
                    },
                });

                				
                result.Add(new RoleControllerModel()
                {
                    Name = "LoginInfo",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "UserInfo",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "Role",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "Product",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "Category",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "TempCard",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "TempCardItem",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "ShippingType",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "Factor",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
								
                result.Add(new RoleControllerModel()
                {
                    Name = "FactorInfo",
                    Roles = new string[] { Admin },
                    Actions = new List<RoleActionModel>()
                    {
                        new RoleActionModel() { Name = "DeletedFirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefaultById", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "FirstOrDefault", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "GetDeletedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "AutoComplete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "PagedList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Restore", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "ToList", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Update", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Delete", Roles = new string[] { Admin } },
                        new RoleActionModel() { Name = "Add", Roles = new string[] { Admin } }
                    },
                });
				

                return result;
            }
        }
    }

    
}