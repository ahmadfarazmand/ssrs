namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class CategoryAdd : BaseSqlAddParam
    {
		
		//[Column(Order = 2)]
		//[Timestamp]
		//[Required]
		//[MaxLength(150) , MinLength(1)]
		//[StringLength (150)]
		public string Name { get; set; }

		//[Column(Order = 3)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public long? UpCategoryId { get; set; }

		//[Column(Order = 999999997)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public bool? IsDeleted { get; set; }

		//[Column(Order = 999999998)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public DateTimeOffset? ModifyDate { get; set; }

		//[Column(Order = 999999999)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public DateTimeOffset? SubmitDate { get; set; }


        public override string GetSpParams()
        {
            var result = "";

            
				result += SqlService.Convert(Name) + ",  ";

				result += SqlService.Convert(UpCategoryId) + ",  ";

				result += SqlService.Convert(IsDeleted) + ",  ";

				result += SqlService.Convert(ModifyDate) + ",  ";

				result += SqlService.Convert(SubmitDate) + " ";


            return result;
        }
    }
}
