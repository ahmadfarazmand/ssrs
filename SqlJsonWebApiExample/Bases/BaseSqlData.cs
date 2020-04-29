using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace SqlJsonWebApiExample.Bases
{
    public class BaseSqlData
    <
        BaseSqlFilterParam,
        BaseSqlListFilterParam,
        BaseSqlPaginationFilterParam,
        BaseSqlAddParam,
        BaseSqlUpdateParam,
        BaseSpName
    > 
    : IDisposable
    where BaseSqlFilterParam : IBaseSqlSpParam
    where BaseSqlListFilterParam : class, IBaseSqlSpParam
    where BaseSqlPaginationFilterParam : class, IBaseSqlSpParam
    where BaseSqlAddParam : class, IBaseSqlSpParam
    where BaseSqlUpdateParam : class, IBaseSqlSpParam
    where BaseSpName : class, IBaseSpName
    {
        protected BaseSpName _spNames;

        public BaseSqlData(string entityName,BaseSpName spNames)
        {
            _spNames = spNames;
            _spNames.EntityName = entityName;
        }

        public virtual async Task<string> Count(BaseSqlFilterParam filter)
        {
            filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.Count + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> ToList(BaseSqlListFilterParam filter)
        {
            filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.ToList + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> PagedList(BaseSqlPaginationFilterParam filter)
        {
            filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.PagedList + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> GetDeletedList(BaseSqlListFilterParam filter)
        {
            filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.GetDeletedList + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> FirstOrDefault(BaseSqlFilterParam filter)
        {
            filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.FirstOrDefault + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> FirstOrDefaultById(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.FirstOrDefaultById + " " + id);
            return result;
        }

        public virtual async Task<string> DeletedFirstOrDefault(BaseSqlFilterParam filter)
        {
            filter.IsDeleted = true;
            var result = await SqlService.GetDataResult(_spNames.DeletedFirstOrDefault + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> AutoComplete(BaseSqlListFilterParam filter)
        {
            filter.IsDeleted = false;
            var result = await SqlService.GetDataResult(_spNames.AutoComplete + " " + filter.GetSpParams());
            return result;
        }

        public virtual async Task<string> Add(BaseSqlAddParam item)
        {
            item.IsDeleted = false;
            item.SubmitDate = DateTimeOffset.Now;
            item.ModifyDate = DateTimeOffset.Now;
            var result = await SqlService.GetDataResult(_spNames.Add + " " + item.GetSpParams());
            return result;
        }

        public virtual async Task<string> Update(BaseSqlUpdateParam item)
        {
            item.IsDeleted = false;
            item.ModifyDate = DateTimeOffset.Now;
            var result = await SqlService.GetDataResult(_spNames.Update + " " + item.GetSpParams());
            return result;
        }

        public virtual async Task<string> Delete(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.Delete + " " + id);
            return result;
        }

        public virtual async Task<string> Restore(long? id)
        {
            var result = await SqlService.GetDataResult(_spNames.Restore + " " + id);
            return result;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(true);
        }

        private void Dispose(bool disposing)
        {
            if (disposing)
            {
                //to do
            }
        }
    }
}