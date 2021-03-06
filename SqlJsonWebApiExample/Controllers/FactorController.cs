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
    [Route("Api/Factor/")]
    public class FactorController : BaseApiController
    {
        public FactorController() : base (EntityNames.Factor)
        {

        }

        [HttpGet, Route("Api/Factor/ToList")]
        public async Task<dynamic> ToList([FromUri] FactorListFilter filter)
        {
            filter = filter ?? new FactorListFilter();
            var result = await _sqlData.Factor.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/PagedList")]
        public async Task<dynamic> PagedList([FromUri] FactorPaginationFilter filter)
        {
            filter = filter ?? new FactorPaginationFilter();
            var result = await _sqlData.Factor.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] FactorListFilter filter)
        {
            filter = filter ?? new FactorListFilter();
            var result = await _sqlData.Factor.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] FactorFilter filter)
        {
            filter = filter ?? new FactorFilter();
            var result = await _sqlData.Factor.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.Factor.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] FactorFilter filter)
        {
            filter = filter ?? new FactorFilter();
            var result = await _sqlData.Factor.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Factor/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] FactorListFilter filter)
        {
            filter = filter ?? new FactorListFilter();
            var result = await _sqlData.Factor.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/Factor/Add")]
        public async Task<dynamic> Add([FromBody]FactorAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Factor.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Factor/Update")]
        public async Task<dynamic> Update([FromBody]FactorUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Factor.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/Factor/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.Factor.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Factor/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.Factor.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}