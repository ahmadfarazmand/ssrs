using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SqlJsonWebApiExample.Bases
{
    public interface IBaseSqlSpParam
    {
        string GetSpParams();
        bool? IsDeleted { get; set; }
        DateTimeOffset? SubmitDate { get; set; }
        DateTimeOffset? ModifyDate { get; set; }

    }

    public class BaseSqlFilterParam : IBaseSqlSpParam
    {
        public virtual bool? IsDeleted { get; set; }
        public virtual DateTimeOffset? SubmitDate { get; set; }
        public virtual DateTimeOffset? ModifyDate { get; set; }
        public virtual string GetSpParams()
        {
            return "";
        }
    }

    public class BaseSqlListFilterParam : IBaseSqlSpParam
    {
        public virtual bool? IsDeleted { get; set; } = false;
        public virtual int? TopCount { get; set; } = 100;
        public virtual DateTimeOffset? SubmitDate { get; set; }
        public virtual DateTimeOffset? ModifyDate { get; set; }
        public virtual string GetSpParams()
        {
            return "";
        }
    }

    public class BaseSqlPaginationFilterParam : IBaseSqlSpParam
    {
        public virtual bool? IsDeleted { get; set; } = false;
        public virtual int? Skip { get; set; } = 0;
        public virtual int? Size { get; set; } = 10;
        public virtual DateTimeOffset? SubmitDate { get; set; }
        public virtual DateTimeOffset? ModifyDate { get; set; }
        public virtual string GetSpParams()
        {
            return "";
        }
    }

    public class BaseSqlAddParam : IBaseSqlSpParam
    {
        public virtual bool? IsDeleted { get; set; } = false;
        public virtual DateTimeOffset? SubmitDate { get; set; }
        public virtual DateTimeOffset? ModifyDate { get; set; }
        public virtual string GetSpParams()
        {
            return "";
        }
    }

    public class BaseSqlUpdateParam : IBaseSqlSpParam
    {
        public virtual bool? IsDeleted { get; set; } = false;
        public virtual DateTimeOffset? SubmitDate { get; set; }
        public virtual DateTimeOffset? ModifyDate { get; set; }

        public virtual string GetSpParams()
        {
            return "";
        }
    }
}