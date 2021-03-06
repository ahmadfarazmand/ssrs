namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class FactorPaginationFilter : BaseSqlPaginationFilterParam
    {
		public override int? Skip { get; set; } = 0;
		public override int? Size { get; set; } = 10;

		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public long? ShippingTypeId { get; set; }
		public string MultiText_ShippingTypeId { get; set; }
		public long? MinShippingTypeId { get; set; }
		public long? MaxShippingTypeId { get; set; }

		public double? ShippingPrice { get; set; }
		public string MultiText_ShippingPrice { get; set; }
		public double? MinShippingPrice { get; set; }
		public double? MaxShippingPrice { get; set; }

		public double? TotalPrice { get; set; }
		public string MultiText_TotalPrice { get; set; }
		public double? MinTotalPrice { get; set; }
		public double? MaxTotalPrice { get; set; }

		public long? FactorInfoId { get; set; }
		public string MultiText_FactorInfoId { get; set; }
		public long? MinFactorInfoId { get; set; }
		public long? MaxFactorInfoId { get; set; }

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

			result += SqlService.Convert(Skip) + ", ";
			result += SqlService.Convert(Size) + ", ";

            
			result += SqlService.Convert(Id) + ", ";
			result += SqlService.Convert(MultiText_Id) + ", ";
			result += SqlService.Convert(MinId) + ", ";
			result += SqlService.Convert(MaxId) + ",  ";

			result += SqlService.Convert(ShippingTypeId) + ", ";
			result += SqlService.Convert(MultiText_ShippingTypeId) + ", ";
			result += SqlService.Convert(MinShippingTypeId) + ", ";
			result += SqlService.Convert(MaxShippingTypeId) + ",  ";

			result += SqlService.Convert(ShippingPrice) + ", ";
			result += SqlService.Convert(MultiText_ShippingPrice) + ", ";
			result += SqlService.Convert(MinShippingPrice) + ", ";
			result += SqlService.Convert(MaxShippingPrice) + ",  ";

			result += SqlService.Convert(TotalPrice) + ", ";
			result += SqlService.Convert(MultiText_TotalPrice) + ", ";
			result += SqlService.Convert(MinTotalPrice) + ", ";
			result += SqlService.Convert(MaxTotalPrice) + ",  ";

			result += SqlService.Convert(FactorInfoId) + ", ";
			result += SqlService.Convert(MultiText_FactorInfoId) + ", ";
			result += SqlService.Convert(MinFactorInfoId) + ", ";
			result += SqlService.Convert(MaxFactorInfoId) + ",  ";

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
