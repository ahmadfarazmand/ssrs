using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web.Http;

namespace SqlJsonWebApiExample.Controllers
{
    
    public class AuthController : ApiController
    {
        // GET api/values

        [HttpGet, Route("api/Auth/Token")]
        public dynamic Token()
        {
            long? userId = 1;
            string role = "admin";
            string expireDate = DateTime.Now.AddDays(2).ToString();
            var code = EncryptCode.Encrypt($"userId={userId}|{role}|{expireDate}");
            return new { JsonString = code };
        }
    }
}
