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
    [Route("Api/LoginInfo/")]
    public class LoginInfoController : BaseApiController
    {
        public LoginInfoController() : base (EntityNames.LoginInfo)
        {

        }

        [HttpGet, Route("Api/LoginInfo/ToList")]
        public async Task<dynamic> ToList([FromUri] LoginInfoListFilter filter)
        {
            filter = filter ?? new LoginInfoListFilter();
            var result = await _sqlData.LoginInfo.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/PagedList")]
        public async Task<dynamic> PagedList([FromUri] LoginInfoPaginationFilter filter)
        {
            filter = filter ?? new LoginInfoPaginationFilter();
            var result = await _sqlData.LoginInfo.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] LoginInfoListFilter filter)
        {
            filter = filter ?? new LoginInfoListFilter();
            var result = await _sqlData.LoginInfo.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] LoginInfoFilter filter)
        {
            filter = filter ?? new LoginInfoFilter();
            var result = await _sqlData.LoginInfo.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.LoginInfo.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] LoginInfoFilter filter)
        {
            filter = filter ?? new LoginInfoFilter();
            var result = await _sqlData.LoginInfo.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/LoginInfo/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] LoginInfoListFilter filter)
        {
            filter = filter ?? new LoginInfoListFilter();
            var result = await _sqlData.LoginInfo.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/LoginInfo/Add")]
        public async Task<dynamic> Add([FromBody]LoginInfoAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.LoginInfo.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/LoginInfo/Update")]
        public async Task<dynamic> Update([FromBody]LoginInfoUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.LoginInfo.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/LoginInfo/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.LoginInfo.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/LoginInfo/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.LoginInfo.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}