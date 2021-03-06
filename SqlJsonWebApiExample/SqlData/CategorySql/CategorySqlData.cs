using SqlJsonWebApiExample.Models.MetaData;
using SqlJsonWebApiExample.Bases;
using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace SqlJsonWebApiExample.SqlData
{
    public class CategorySqlData : BaseSqlData<CategoryFilter, CategoryListFilter, CategoryPaginationFilter, CategoryAdd, CategoryUpdate, BaseSpName>
    {
        public CategorySqlData(string entityName, BaseSpName spNames) : base(entityName, spNames)
        {
            _spNames.EntityName = entityName;
        }

        public override async Task<string> Count(CategoryFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.Count + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> ToList(CategoryListFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.ToList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> PagedList(CategoryPaginationFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.PagedList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> GetDeletedList(CategoryListFilter filter)
        {
			filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.GetDeletedList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> FirstOrDefault(CategoryFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.FirstOrDefault + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> FirstOrDefaultById(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.FirstOrDefaultById + " " + id);
            return result;
        }

        public override async Task<string> DeletedFirstOrDefault(CategoryFilter filter)
        {
			filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.DeletedFirstOrDefault + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> AutoComplete(CategoryListFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.AutoComplete + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> Add(CategoryAdd item)
        {
			item.IsDeleted = false;
			item.SubmitDate = DateTimeOffset.Now;
			item.ModifyDate = DateTimeOffset.Now;
            var result = await SqlService.GetDataResult(_spNames.Add + " " + item.GetSpParams());
            return result;
        }

        public override async Task<string> Update(CategoryUpdate item)
        {
			item.IsDeleted = false;
			item.ModifyDate = DateTimeOffset.Now;
            var result = await SqlService.GetDataResult(_spNames.Update + " " + item.GetSpParams());
            return result;
        }

        public override async Task<string> Delete(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.Delete + " " + id);
            return result;
        }

        public override async Task<string> Restore(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.Restore + " " + id);
            return result;
        }
    }
}
