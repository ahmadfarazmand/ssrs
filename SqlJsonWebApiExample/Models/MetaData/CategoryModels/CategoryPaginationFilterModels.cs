namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class CategoryPaginationFilter : BaseSqlPaginationFilterParam
    {
		public override int? Skip { get; set; } = 0;
		public override int? Size { get; set; } = 10;

		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public string Name { get; set; }
		public string MultiText_Name { get; set; }

		public long? UpCategoryId { get; set; }
		public string MultiText_UpCategoryId { get; set; }
		public long? MinUpCategoryId { get; set; }
		public long? MaxUpCategoryId { get; set; }

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

			result += SqlService.Convert(Name) + ", ";

			result += SqlService.Convert(MultiText_Name) + ",  ";


			result += SqlService.Convert(UpCategoryId) + ", ";
			result += SqlService.Convert(MultiText_UpCategoryId) + ", ";
			result += SqlService.Convert(MinUpCategoryId) + ", ";
			result += SqlService.Convert(MaxUpCategoryId) + ",  ";

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
