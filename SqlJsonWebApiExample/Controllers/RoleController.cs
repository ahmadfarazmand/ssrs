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
    [Route("Api/Role/")]
    public class RoleController : BaseApiController
    {
        public RoleController() : base (EntityNames.Role)
        {

        }

        [HttpGet, Route("Api/Role/ToList")]
        public async Task<dynamic> ToList([FromUri] RoleListFilter filter)
        {
            filter = filter ?? new RoleListFilter();
            var result = await _sqlData.Role.ToList(filter);

            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/PagedList")]
        public async Task<dynamic> PagedList([FromUri] RolePaginationFilter filter)
        {
            filter = filter ?? new RolePaginationFilter();
            var result = await _sqlData.Role.PagedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/GetDeletedList")]
        public async Task<dynamic> GetDeletedList([FromUri] RoleListFilter filter)
        {
            filter = filter ?? new RoleListFilter();
            var result = await _sqlData.Role.GetDeletedList(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/FirstOrDefault")]
        public async Task<dynamic> FirstOrDefault([FromUri] RoleFilter filter)
        {
            filter = filter ?? new RoleFilter();
            var result = await _sqlData.Role.FirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/FirstOrDefaultById/{id}")]
        public async Task<dynamic> FirstOrDefaultById(long? id)
        {
            if (id == null)
                return new { JsonString = "Error" };
            var result = await _sqlData.Role.FirstOrDefaultById(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/DeletedFirstOrDefault")]
        public async Task<dynamic> DeletedFirstOrDefault([FromUri] RoleFilter filter)
        {
            filter = filter ?? new RoleFilter();
            var result = await _sqlData.Role.DeletedFirstOrDefault(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpGet, Route("Api/Role/AutoComplete")]
        public async Task<dynamic> AutoComplete([FromUri] RoleListFilter filter)
        {
            filter = filter ?? new RoleListFilter();
            var result = await _sqlData.Role.AutoComplete(filter);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPost, Route("Api/Role/Add")]
        public async Task<dynamic> Add([FromBody]RoleAdd item)
        {
            if(item == null)
                return new { JsonString = "Error" };

            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Role.Add(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Role/Update")]
        public async Task<dynamic> Update([FromBody]RoleUpdate item)
        {
            if (item == null)
                return new { JsonString = "Error" };
            var currentUser = JwtIdentity.UserInfo(Thread.CurrentPrincipal.Identity);
            //item.SubmiterUserId = currentUser.Id;
            var result = await _sqlData.Role.Update(item);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpDelete, Route("Api/Role/Delete/{id}")]
        public async Task<dynamic> Delete([FromUri] long? id)
        {
            var result = await _sqlData.Role.Delete(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }

        [HttpPut, Route("Api/Role/Restore/{id}")]
        public async Task<dynamic> Restore([FromUri] long? id)
        {
            var result = await _sqlData.Role.Restore(id);
            return new { Result = JsonConvert.DeserializeObject(result) };
        }
    }
}