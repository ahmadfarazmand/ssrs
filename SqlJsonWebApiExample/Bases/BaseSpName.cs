using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SqlJsonWebApiExample.Bases
{
    public interface IBaseSpName
    {
        //IBaseSpName BaseSpNameCreate();
        string EntityName { get; set; }
        string Count { get; }
        string ToList { get; }
        string PagedList { get; }
        string GetDeletedList { get; }
        string FirstOrDefault { get; }
        string FirstOrDefaultById { get; }
        string DeletedFirstOrDefault { get; }
        string AutoComplete { get; }
        string Add { get; }
        string Update { get; }
        string Delete { get; }
        string Restore { get; }
    }

    public class BaseSpName : IBaseSpName
    {
        //public IBaseSpName BaseSpNameCreate()
        //{
        //    IBaseSpName thisObject = new BaseSpName();

        //    return thisObject;
        //}

        //static void Main()
        //{
        //    IBaseSpName thisObject = new BaseSpName();

        //    thisObject.BaseSpNameCreate();
        //}

        public virtual string EntityName { get; set; }
        public virtual string Count { get { return $"[SpJson].[{EntityName}_Count] "; } }
        public virtual string ToList { get { return $"[SpJson].[{EntityName}_ToList] "; } }
        public virtual string PagedList { get { return $"[SpJson].[{EntityName}_PageList]"; } }
        public virtual string GetDeletedList { get { return $"[SpJson].[{EntityName}_ToList]"; } }
        public virtual string FirstOrDefault { get { return $"[SpJson].[{EntityName}_FirstOrDefault]"; } }
        public virtual string FirstOrDefaultById { get { return $"[SpJson].[{EntityName}_FirstOrDefaultById]"; } }
        public virtual string DeletedFirstOrDefault { get { return $"[SpJson].[{EntityName}_FirstOrDefault]"; } }
        public virtual string AutoComplete { get { return $"[SpJson].[{EntityName}_AutoComplete]"; } }
        public virtual string Add { get { return $"[SpJson].[{EntityName}_AddNewData]"; } }
        public virtual string Update { get { return $"[SpJson].[{EntityName}_UpdateData]"; } }
        public virtual string Delete { get { return $"[SpJson].[{EntityName}_DeleteData]"; } }
        public virtual string Restore { get { return $"[SpJson].[{EntityName}_RestoreData]"; } }

        
    }
}