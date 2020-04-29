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
    [Route("Api/FactorInfo/")]
    public class FactorInfoController : BaseApiController
    {
        public FactorInfoController() : base (EntityNames.FactorInfo)
        {

        }

        [HttpGet, Route("Api/FactorInfo/ToList")]
        public async Task<dynamic> ToList([FromUri] FactorInfoListFilter filter)
        {
            filter = filter ?? new FactorInfoListFilter();
            var result = await _sqlData.FactorInfo.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/PagedList")]
        public async Task<dynamic> PagedList([FromUri] FactorInfoPaginationFilter filter)
        {
            filter = filter ?? new FactorInfoPaginationFilter();
            var result = await _sqlData.FactorInfo.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] FactorInfoListFilter filter)
        {
            filter = filter ?? new FactorInfoListFilter();
            var result = await _sqlData.FactorInfo.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] FactorInfoFilter filter)
        {
            filter = filter ?? new FactorInfoFilter();
            var result = await _sqlData.FactorInfo.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.FactorInfo.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] FactorInfoFilter filter)
        {
            filter = filter ?? new FactorInfoFilter();
            var result = await _sqlData.FactorInfo.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/FactorInfo/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] FactorInfoListFilter filter)
        {
            filter = filter ?? new FactorInfoListFilter();
            var result = await _sqlData.FactorInfo.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/FactorInfo/Add")]
        public async Task<dynamic> Add([FromBody]FactorInfoAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.FactorInfo.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/FactorInfo/Update")]
        public async Task<dynamic> Update([FromBody]FactorInfoUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.FactorInfo.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/FactorInfo/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.FactorInfo.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/FactorInfo/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.FactorInfo.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}