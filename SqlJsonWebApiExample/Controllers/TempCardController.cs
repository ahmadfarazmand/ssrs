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
    [Route("Api/TempCard/")]
    public class TempCardController : BaseApiController
    {
        public TempCardController() : base (EntityNames.TempCard)
        {

        }

        [HttpGet, Route("Api/TempCard/ToList")]
        public async Task<dynamic> ToList([FromUri] TempCardListFilter filter)
        {
            filter = filter ?? new TempCardListFilter();
            var result = await _sqlData.TempCard.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/PagedList")]
        public async Task<dynamic> PagedList([FromUri] TempCardPaginationFilter filter)
        {
            filter = filter ?? new TempCardPaginationFilter();
            var result = await _sqlData.TempCard.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] TempCardListFilter filter)
        {
            filter = filter ?? new TempCardListFilter();
            var result = await _sqlData.TempCard.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] TempCardFilter filter)
        {
            filter = filter ?? new TempCardFilter();
            var result = await _sqlData.TempCard.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.TempCard.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] TempCardFilter filter)
        {
            filter = filter ?? new TempCardFilter();
            var result = await _sqlData.TempCard.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/TempCard/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] TempCardListFilter filter)
        {
            filter = filter ?? new TempCardListFilter();
            var result = await _sqlData.TempCard.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/TempCard/Add")]
        public async Task<dynamic> Add([FromBody]TempCardAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.TempCard.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/TempCard/Update")]
        public async Task<dynamic> Update([FromBody]TempCardUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.TempCard.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/TempCard/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.TempCard.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/TempCard/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.TempCard.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}