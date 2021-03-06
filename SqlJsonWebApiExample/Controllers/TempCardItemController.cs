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
    [Route("Api/TempCardItem/")]
    public class TempCardItemController : BaseApiController
    {
        public TempCardItemController() : base (EntityNames.TempCardItem)
        {

        }

        [HttpGet, Route("Api/TempCardItem/ToList")]
        public async Task<dynamic> ToList([FromUri] TempCardItemListFilter filter)
        {
            filter = filter ?? new TempCardItemListFilter();
            var result = await _sqlData.TempCardItem.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/PagedList")]
        public async Task<dynamic> PagedList([FromUri] TempCardItemPaginationFilter filter)
        {
            filter = filter ?? new TempCardItemPaginationFilter();
            var result = await _sqlData.TempCardItem.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] TempCardItemListFilter filter)
        {
            filter = filter ?? new TempCardItemListFilter();
            var result = await _sqlData.TempCardItem.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] TempCardItemFilter filter)
        {
            filter = filter ?? new TempCardItemFilter();
            var result = await _sqlData.TempCardItem.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.TempCardItem.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] TempCardItemFilter filter)
        {
            filter = filter ?? new TempCardItemFilter();
            var result = await _sqlData.TempCardItem.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCardItem/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] TempCardItemListFilter filter)
        {
            filter = filter ?? new TempCardItemListFilter();
            var result = await _sqlData.TempCardItem.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/TempCardItem/Add")]
        public async Task<dynamic> Add([FromBody]TempCardItemAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.TempCardItem.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/TempCardItem/Update")]
        public async Task<dynamic> Update([FromBody]TempCardItemUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.TempCardItem.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/TempCardItem/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.TempCardItem.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/TempCardItem/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.TempCardItem.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}