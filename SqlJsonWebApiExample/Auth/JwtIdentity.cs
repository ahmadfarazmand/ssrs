using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;

namespace SqlJsonWebApiExample
{
    public class JwtIdentity
    {
        public static JwtUserInfo UserInfo(IIdentity identity)
        {
            if(identity.IsAuthenticated)
            {
                try
                {
                    var infoes = identity.Name.Split('|');
                    DateTime expDate = DateTime.Now.AddDays(-30);
                    bool haveDate = false;
                    haveDate = DateTime.TryParse(infoes[2], out expDate);
                    return new JwtUserInfo()
                    {
                        ExpireDate = expDate,
                        Id = long.Parse(infoes[0].Replace("userId=", "")),
                        Role = infoes[1],
                        TokenString = identity.Name,
                        IsAuthenticated = true,
                        IsInvalidToken = false,
                    };
                }
                catch (Exception)
                {
                    return new JwtUserInfo() { IsInvalidToken = true, IsAuthenticated = false, TokenString = identity.Name, Id = -999999999999999999, ExpireDate = DateTime.Now.AddSeconds(-1), Role = "" };
                }
            }

            return new JwtUserInfo() { IsInvalidToken = false, IsAuthenticated = false, TokenString = identity.Name, Id = -999999999999999999, ExpireDate = DateTime.Now.AddSeconds(-1), Role = "" };
        }
    }

    public class JwtUserInfo
    {
        public bool IsAuthenticated { get; set; }

        public bool IsInvalidToken { get; set; }

        public long Id { get; set; }

        public string Role { get; set; }

        public DateTime ExpireDate { get; set; }

        public string TokenString { get; set; }
    }
}