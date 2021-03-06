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
    [Route("Api/ShippingType/")]
    public class ShippingTypeController : BaseApiController
    {
        public ShippingTypeController() : base (EntityNames.ShippingType)
        {

        }

        [HttpGet, Route("Api/ShippingType/ToList")]
        public async Task<dynamic> ToList([FromUri] ShippingTypeListFilter filter)
        {
            filter = filter ?? new ShippingTypeListFilter();
            var result = await _sqlData.ShippingType.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/PagedList")]
        public async Task<dynamic> PagedList([FromUri] ShippingTypePaginationFilter filter)
        {
            filter = filter ?? new ShippingTypePaginationFilter();
            var result = await _sqlData.ShippingType.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] ShippingTypeListFilter filter)
        {
            filter = filter ?? new ShippingTypeListFilter();
            var result = await _sqlData.ShippingType.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] ShippingTypeFilter filter)
        {
            filter = filter ?? new ShippingTypeFilter();
            var result = await _sqlData.ShippingType.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.ShippingType.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] ShippingTypeFilter filter)
        {
            filter = filter ?? new ShippingTypeFilter();
            var result = await _sqlData.ShippingType.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/ShippingType/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] ShippingTypeListFilter filter)
        {
            filter = filter ?? new ShippingTypeListFilter();
            var result = await _sqlData.ShippingType.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/ShippingType/Add")]
        public async Task<dynamic> Add([FromBody]ShippingTypeAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.ShippingType.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/ShippingType/Update")]
        public async Task<dynamic> Update([FromBody]ShippingTypeUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.ShippingType.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/ShippingType/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.ShippingType.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/ShippingType/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.ShippingType.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}