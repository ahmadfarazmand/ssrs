namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class TempCardItemListFilter : BaseSqlListFilterParam
    {
		public override int? TopCount { get; set; } = 100;

		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public int? Count { get; set; }
		public string MultiText_Count { get; set; }
		public int? MinCount { get; set; }
		public int? MaxCount { get; set; }

		public long? ProductId { get; set; }
		public string MultiText_ProductId { get; set; }
		public long? MinProductId { get; set; }
		public long? MaxProductId { get; set; }

		public long? TempCardId { get; set; }
		public string MultiText_TempCardId { get; set; }
		public long? MinTempCardId { get; set; }
		public long? MaxTempCardId { get; set; }

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

			result += SqlService.Convert(Count) + ", ";
			result += SqlService.Convert(MultiText_Count) + ", ";
			result += SqlService.Convert(MinCount) + ", ";
			result += SqlService.Convert(MaxCount) + ",  ";

			result += SqlService.Convert(ProductId) + ", ";
			result += SqlService.Convert(MultiText_ProductId) + ", ";
			result += SqlService.Convert(MinProductId) + ", ";
			result += SqlService.Convert(MaxProductId) + ",  ";

			result += SqlService.Convert(TempCardId) + ", ";
			result += SqlService.Convert(MultiText_TempCardId) + ", ";
			result += SqlService.Convert(MinTempCardId) + ", ";
			result += SqlService.Convert(MaxTempCardId) + ",  ";

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
