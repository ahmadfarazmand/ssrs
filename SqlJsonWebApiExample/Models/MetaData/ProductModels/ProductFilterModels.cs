namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class ProductFilter : BaseSqlFilterParam
    {
		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public double? Price { get; set; }
		public string MultiText_Price { get; set; }
		public double? MinPrice { get; set; }
		public double? MaxPrice { get; set; }

		public int? Count { get; set; }
		public string MultiText_Count { get; set; }
		public int? MinCount { get; set; }
		public int? MaxCount { get; set; }

		public string Title { get; set; }
		public string MultiText_Title { get; set; }

		public int? OffPercent { get; set; }
		public string MultiText_OffPercent { get; set; }
		public int? MinOffPercent { get; set; }
		public int? MaxOffPercent { get; set; }

		public long? CategoryId { get; set; }
		public string MultiText_CategoryId { get; set; }
		public long? MinCategoryId { get; set; }
		public long? MaxCategoryId { get; set; }

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

            
			result += SqlService.Convert(Id) + ", ";
			result += SqlService.Convert(MultiText_Id) + ", ";
			result += SqlService.Convert(MinId) + ", ";
			result += SqlService.Convert(MaxId) + ",  ";

			result += SqlService.Convert(Price) + ", ";
			result += SqlService.Convert(MultiText_Price) + ", ";
			result += SqlService.Convert(MinPrice) + ", ";
			result += SqlService.Convert(MaxPrice) + ",  ";

			result += SqlService.Convert(Count) + ", ";
			result += SqlService.Convert(MultiText_Count) + ", ";
			result += SqlService.Convert(MinCount) + ", ";
			result += SqlService.Convert(MaxCount) + ",  ";

			result += SqlService.Convert(Title) + ", ";

			result += SqlService.Convert(MultiText_Title) + ",  ";


			result += SqlService.Convert(OffPercent) + ", ";
			result += SqlService.Convert(MultiText_OffPercent) + ", ";
			result += SqlService.Convert(MinOffPercent) + ", ";
			result += SqlService.Convert(MaxOffPercent) + ",  ";

			result += SqlService.Convert(CategoryId) + ", ";
			result += SqlService.Convert(MultiText_CategoryId) + ", ";
			result += SqlService.Convert(MinCategoryId) + ", ";
			result += SqlService.Convert(MaxCategoryId) + ",  ";

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
