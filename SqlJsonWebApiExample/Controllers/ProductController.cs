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
    [Route("Api/Product/")]
    public class ProductController : BaseApiController
    {
        public ProductController() : base (EntityNames.Product)
        {

        }

        [HttpGet, Route("Api/Product/ToList")]
        public async Task<dynamic> ToList([FromUri] ProductListFilter filter)
        {
            filter = filter ?? new ProductListFilter();
            var result = await _sqlData.Product.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/PagedList")]
        public async Task<dynamic> PagedList([FromUri] ProductPaginationFilter filter)
        {
            filter = filter ?? new ProductPaginationFilter();
            var result = await _sqlData.Product.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] ProductListFilter filter)
        {
            filter = filter ?? new ProductListFilter();
            var result = await _sqlData.Product.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] ProductFilter filter)
        {
            filter = filter ?? new ProductFilter();
            var result = await _sqlData.Product.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.Product.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] ProductFilter filter)
        {
            filter = filter ?? new ProductFilter();
            var result = await _sqlData.Product.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Product/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] ProductListFilter filter)
        {
            filter = filter ?? new ProductListFilter();
            var result = await _sqlData.Product.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/Product/Add")]
        public async Task<dynamic> Add([FromBody]ProductAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Product.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Product/Update")]
        public async Task<dynamic> Update([FromBody]ProductUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Product.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/Product/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.Product.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Product/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.Product.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}