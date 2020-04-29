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
    public class TempCardSqlData : BaseSqlData<TempCardFilter, TempCardListFilter, TempCardPaginationFilter, TempCardAdd, TempCardUpdate, BaseSpName>
    {
        public TempCardSqlData(string entityName, BaseSpName spNames) : base(entityName, spNames)
        {
            _spNames.EntityName = entityName;
        }

        public override async Task<string> Count(TempCardFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.Count + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> ToList(TempCardListFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.ToList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> PagedList(TempCardPaginationFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.PagedList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> GetDeletedList(TempCardListFilter filter)
        {
			filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.GetDeletedList + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> FirstOrDefault(TempCardFilter filter)
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

        public override async Task<string> DeletedFirstOrDefault(TempCardFilter filter)
        {
			filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.DeletedFirstOrDefault + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> AutoComplete(TempCardListFilter filter)
        {
			filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.AutoComplete + " " + filter.GetSpParams());
            return result;
        }

        public override async Task<string> Add(TempCardAdd item)
        {
			item.IsDeleted = false;
			item.SubmitDate = DateTimeOffset.Now;
			item.ModifyDate = DateTimeOffset.Now;
            var result = await SqlService.GetDataResult(_spNames.Add + " " + item.GetSpParams());
            return result;
        }

        public override async Task<string> Update(TempCardUpdate item)
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
