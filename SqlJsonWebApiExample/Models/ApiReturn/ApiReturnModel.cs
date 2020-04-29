using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SqlJsonWebApiExample.Models.ApiReturn
{
    public class ApiReturnModel
    {
        public bool? Status { get; set; }

        public string Message { get; set; }

        public string JsonDataString { get; set; }
    }
}