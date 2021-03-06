namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class TempCardListFilter : BaseSqlListFilterParam
    {
		public override int? TopCount { get; set; } = 100;

		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public long? UserInfoId { get; set; }
		public string MultiText_UserInfoId { get; set; }
		public long? MinUserInfoId { get; set; }
		public long? MaxUserInfoId { get; set; }

		public long? FactorId { get; set; }
		public string MultiText_FactorId { get; set; }
		public long? MinFactorId { get; set; }
		public long? MaxFactorId { get; set; }

		public bool? IsDeleted { get; set; }
		public string MultiText_IsDeleted { get; set; }

		public DateTimeOffset? ModifyDate { get; set; }
		public string MultiText_ModifyDate { get; set; }
		public DateTimeOffset? MinModifyDate { get; set; }
		public DateTimeOffset? MaxModifyDate { get; set; }

		public DateTimeOffset? SubmitDate { get; set; }
		public string MultiText_SubmitDate { get; set; }
		public DateTimeOffset? MinSubmitDate { get; set; }
		public DateTimeOffset? MaxSubmitDate { get; set; }


        public override string GetSpParams()
        {
            var result = "";

			result += SqlService.Convert(TopCount) + ", ";
            
			result += SqlService.Convert(Id) + ", ";
			result += SqlService.Convert(MultiText_Id) + ", ";
			result += SqlService.Convert(MinId) + ", ";
			result += SqlService.Convert(MaxId) + ",  ";

			result += SqlService.Convert(UserInfoId) + ", ";
			result += SqlService.Convert(MultiText_UserInfoId) + ", ";
			result += SqlService.Convert(MinUserInfoId) + ", ";
			result += SqlService.Convert(MaxUserInfoId) + ",  ";

			result += SqlService.Convert(FactorId) + ", ";
			result += SqlService.Convert(MultiText_FactorId) + ", ";
			result += SqlService.Convert(MinFactorId) + ", ";
			result += SqlService.Convert(MaxFactorId) + ",  ";

			result += SqlService.Convert(IsDeleted) + ", ";

			result += SqlService.Convert(MultiText_IsDeleted) + ",  ";


			result += SqlService.Convert(ModifyDate) + ", ";
			result += SqlService.Convert(MultiText_ModifyDate) + ", ";
			result += SqlService.Convert(MinModifyDate) + ", ";
			result += SqlService.Convert(MaxModifyDate) + ",  ";

			result += SqlService.Convert(SubmitDate) + ", ";
			result += SqlService.Convert(MultiText_SubmitDate) + ", ";
			result += SqlService.Convert(MinSubmitDate) + ", ";
			result += SqlService.Convert(MaxSubmitDate) + " ";


            return result;
        }
    }
}
