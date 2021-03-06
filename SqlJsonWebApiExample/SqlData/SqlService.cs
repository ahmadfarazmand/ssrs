using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Spatial;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlJsonWebApiExample
{
    public class SqlService
    {
        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString;
            }
        }

        public async static Task<string> GetDataResult(string query)
        {
            try
            {
                var queryWithForJson = query;
                var conn = new SqlConnection(SqlService.ConnectionString);
                var cmd = new SqlCommand(queryWithForJson, conn);
                await conn.OpenAsync();
                var jsonResult = new StringBuilder();
                var reader = await cmd.ExecuteReaderAsync();
                if (!reader.HasRows)
                {
                    jsonResult.Append("null");
                }
                else
                {
                    while (reader.Read())
                    {
                        jsonResult.Append(reader.GetValue(0).ToString());
                    }
                }
                conn.Close();
                return ReturnData(jsonResult.ToString());
            }
            catch (Exception e)
            {
                return GeneralGetDataError(e.Message);
            }
        }

        public static string ReturnData(string json)
        {
            return "{\"Message\":\"DONE\",\"Status\":true,\"Data\":" + json + "}";
        }

        public static string GeneralGetDataError(string message)
        {
            return "{\"Message\":\"" + message + "\",\"Status\":false}";
        }

        public static string Convert(long? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}";

            return result;
        }

        public static string Convert(byte[] value)
        {
            var result = "NULL";

            return result;
        }

        public static string Convert(bool? value)
        {
            var result = $"{(value.HasValue ? value.Value ? (1).ToString() : (0).ToString() : "NULL")}";

            return result;
        }

        public static string Convert(string value)
        {
            var result = $"{(value != null && value.Length > 0 ? "'" + value.ToString() + "'" : "NULL")}";

            return result;
        }

        public static string Convert(DateTime? value)
        {
            var result = $"{(value.HasValue ? "'" + value.Value.ToLongDateString().Replace("/", "-") + "'" : "NULL")}";

            return result;
        }

        public static string Convert(DateTimeOffset? value)
        {
            var result = $"{(value.HasValue ? "'" + value.Value.Date.ToString("o").Replace("/","-") + "'" : "NULL")}";

            return result;
        }

        public static string Convert(decimal? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}"; ;

            return result;
        }

        public static string Convert(double? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}";

            return result;
        }

        public static string Convert(DbGeography value)
        {
            var result = "NULL";

            return result;
        }

        public static string Convert(DbGeometry value)
        {
            var result = "NULL";

            return result;
        }

        public static string Convert(int? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}";

            return result;
        }

        public static string Convert(float? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}";

            return result;
        }

        public static string Convert(short? value)
        {
            var result = $"{(value.HasValue ? value.ToString() : "NULL")}";

            return result;
        }

        public static string Convert(TimeSpan? value)
        {
            var result = $"{(value.HasValue ? "'" + value.Value.ToString() + "'" : "NULL")}";

            return result;
        }

        public static string Convert(byte? value)
        {
            var result = "NULL";

            return result;
        }
    }
}