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
    [Route("Api/UserInfo/")]
    public class UserInfoController : BaseApiController
    {
        public UserInfoController() : base (EntityNames.UserInfo)
        {

        }

        [HttpGet, Route("Api/UserInfo/ToList")]
        public async Task<dynamic> ToList([FromUri] UserInfoListFilter filter)
        {
            filter = filter ?? new UserInfoListFilter();
            var result = await _sqlData.UserInfo.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/PagedList")]
        public async Task<dynamic> PagedList([FromUri] UserInfoPaginationFilter filter)
        {
            filter = filter ?? new UserInfoPaginationFilter();
            var result = await _sqlData.UserInfo.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] UserInfoListFilter filter)
        {
            filter = filter ?? new UserInfoListFilter();
            var result = await _sqlData.UserInfo.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] UserInfoFilter filter)
        {
            filter = filter ?? new UserInfoFilter();
            var result = await _sqlData.UserInfo.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.UserInfo.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] UserInfoFilter filter)
        {
            filter = filter ?? new UserInfoFilter();
            var result = await _sqlData.UserInfo.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/UserInfo/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] UserInfoListFilter filter)
        {
            filter = filter ?? new UserInfoListFilter();
            var result = await _sqlData.UserInfo.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/UserInfo/Add")]
        public async Task<dynamic> Add([FromBody]UserInfoAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.UserInfo.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/UserInfo/Update")]
        public async Task<dynamic> Update([FromBody]UserInfoUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.UserInfo.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/UserInfo/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.UserInfo.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/UserInfo/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.UserInfo.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}