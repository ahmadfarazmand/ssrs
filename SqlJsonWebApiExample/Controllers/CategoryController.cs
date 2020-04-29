using SqlJsonWebApiExample.Models.MetaData;
using SqlJsonWebApiExample.SqlData;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;

namespace SqlJsonWebApiExample.Controllers
{
    [Route("Api/Category/")]
    public class CategoryController : BaseApiController
    {
        public CategoryController() : base (EntityNames.Category)
        {

        }

        [HttpGet, Route("Api/Category/ToList")]
        public async Task<dynamic> ToList([FromUri] CategoryListFilter filter)
        {
            filter = filter ?? new CategoryListFilter();
            var result = await _sqlData.Category.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/PagedList")]
        public async Task<dynamic> PagedList([FromUri] CategoryPaginationFilter filter)
        {
            filter = filter ?? new CategoryPaginationFilter();
            var result = await _sqlData.Category.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] CategoryListFilter filter)
        {
            filter = filter ?? new CategoryListFilter();
            var result = await _sqlData.Category.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] CategoryFilter filter)
        {
            filter = filter ?? new CategoryFilter();
            var result = await _sqlData.Category.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.Category.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] CategoryFilter filter)
        {
            filter = filter ?? new CategoryFilter();
            var result = await _sqlData.Category.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Category/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] CategoryListFilter filter)
        {
            filter = filter ?? new CategoryListFilter();
            var result = await _sqlData.Category.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/Category/Add")]
        public async Task<dynamic> Add([FromBody]CategoryAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Category.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Category/Update")]
        public async Task<dynamic> Update([FromBody]CategoryUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Category.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/Category/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.Category.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Category/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.Category.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}