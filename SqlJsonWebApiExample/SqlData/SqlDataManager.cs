using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SqlJsonWebApiExample.Bases;
using SqlJsonWebApiExample.Models.MetaData;
using SqlJsonWebApiExample.SqlData;

namespace SqlJsonWebApiExample
{
    public class SqlDataManager
    {
        protected string _entityName = "";
        protected BaseSpName _spName;
        public SqlDataManager(string entityName, BaseSpName spName)
        {
            _spName = spName;
            _entityName = entityName;
        }

        		
		private BaseSqlData<LoginInfoFilter, LoginInfoListFilter, LoginInfoPaginationFilter, LoginInfoAdd, LoginInfoUpdate, BaseSpName> _LoginInfo;

        public BaseSqlData<LoginInfoFilter, LoginInfoListFilter, LoginInfoPaginationFilter, LoginInfoAdd, LoginInfoUpdate, BaseSpName> LoginInfo
        {
            get { if (_LoginInfo == null)  _LoginInfo =  new LoginInfoSqlData(_entityName, _spName); return _LoginInfo; }
        }
		
		private BaseSqlData<UserInfoFilter, UserInfoListFilter, UserInfoPaginationFilter, UserInfoAdd, UserInfoUpdate, BaseSpName> _UserInfo;

        public BaseSqlData<UserInfoFilter, UserInfoListFilter, UserInfoPaginationFilter, UserInfoAdd, UserInfoUpdate, BaseSpName> UserInfo
        {
            get { if (_UserInfo == null)  _UserInfo =  new UserInfoSqlData(_entityName, _spName); return _UserInfo; }
        }
		
		private BaseSqlData<RoleFilter, RoleListFilter, RolePaginationFilter, RoleAdd, RoleUpdate, BaseSpName> _Role;

        public BaseSqlData<RoleFilter, RoleListFilter, RolePaginationFilter, RoleAdd, RoleUpdate, BaseSpName> Role
        {
            get { if (_Role == null)  _Role =  new RoleSqlData(_entityName, _spName); return _Role; }
        }
		
		private BaseSqlData<ProductFilter, ProductListFilter, ProductPaginationFilter, ProductAdd, ProductUpdate, BaseSpName> _Product;

        public BaseSqlData<ProductFilter, ProductListFilter, ProductPaginationFilter, ProductAdd, ProductUpdate, BaseSpName> Product
        {
            get { if (_Product == null)  _Product =  new ProductSqlData(_entityName, _spName); return _Product; }
        }
		
		private BaseSqlData<CategoryFilter, CategoryListFilter, CategoryPaginationFilter, CategoryAdd, CategoryUpdate, BaseSpName> _Category;

        public BaseSqlData<CategoryFilter, CategoryListFilter, CategoryPaginationFilter, CategoryAdd, CategoryUpdate, BaseSpName> Category
        {
            get { if (_Category == null)  _Category =  new CategorySqlData(_entityName, _spName); return _Category; }
        }
		
		private BaseSqlData<TempCardFilter, TempCardListFilter, TempCardPaginationFilter, TempCardAdd, TempCardUpdate, BaseSpName> _TempCard;

        public BaseSqlData<TempCardFilter, TempCardListFilter, TempCardPaginationFilter, TempCardAdd, TempCardUpdate, BaseSpName> TempCard
        {
            get { if (_TempCard == null)  _TempCard =  new TempCardSqlData(_entityName, _spName); return _TempCard; }
        }
		
		private BaseSqlData<TempCardItemFilter, TempCardItemListFilter, TempCardItemPaginationFilter, TempCardItemAdd, TempCardItemUpdate, BaseSpName> _TempCardItem;

        public BaseSqlData<TempCardItemFilter, TempCardItemListFilter, TempCardItemPaginationFilter, TempCardItemAdd, TempCardItemUpdate, BaseSpName> TempCardItem
        {
            get { if (_TempCardItem == null)  _TempCardItem =  new TempCardItemSqlData(_entityName, _spName); return _TempCardItem; }
        }
		
		private BaseSqlData<ShippingTypeFilter, ShippingTypeListFilter, ShippingTypePaginationFilter, ShippingTypeAdd, ShippingTypeUpdate, BaseSpName> _ShippingType;

        public BaseSqlData<ShippingTypeFilter, ShippingTypeListFilter, ShippingTypePaginationFilter, ShippingTypeAdd, ShippingTypeUpdate, BaseSpName> ShippingType
        {
            get { if (_ShippingType == null)  _ShippingType =  new ShippingTypeSqlData(_entityName, _spName); return _ShippingType; }
        }
		
		private BaseSqlData<FactorFilter, FactorListFilter, FactorPaginationFilter, FactorAdd, FactorUpdate, BaseSpName> _Factor;

        public BaseSqlData<FactorFilter, FactorListFilter, FactorPaginationFilter, FactorAdd, FactorUpdate, BaseSpName> Factor
        {
            get { if (_Factor == null)  _Factor =  new FactorSqlData(_entityName, _spName); return _Factor; }
        }
		
		private BaseSqlData<FactorInfoFilter, FactorInfoListFilter, FactorInfoPaginationFilter, FactorInfoAdd, FactorInfoUpdate, BaseSpName> _FactorInfo;

        public BaseSqlData<FactorInfoFilter, FactorInfoListFilter, FactorInfoPaginationFilter, FactorInfoAdd, FactorInfoUpdate, BaseSpName> FactorInfo
        {
            get { if (_FactorInfo == null)  _FactorInfo =  new FactorInfoSqlData(_entityName, _spName); return _FactorInfo; }
        }



    }
}