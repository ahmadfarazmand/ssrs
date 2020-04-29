namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class ProductUpdate : BaseSqlUpdateParam
    {
		
		//[Column(Order = 1)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public long? Id { get; set; }

		//[Column(Order = 2)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public double? Price { get; set; }

		//[Column(Order = 3)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public int? Count { get; set; }

		//[Column(Order = 4)]
		//[Timestamp]
		//[Required]
		//[MaxLength(150) , MinLength(1)]
		//[StringLength (150)]
		public string Title { get; set; }

		//[Column(Order = 5)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public int? OffPercent { get; set; }

		//[Column(Order = 6)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public long? CategoryId { get; set; }

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


        public override string GetSpParams()
        {
            var result = "";

            
				result += SqlService.Convert(Id) + ",  ";

				result += SqlService.Convert(Price) + ",  ";

				result += SqlService.Convert(Count) + ",  ";

				result += SqlService.Convert(Title) + ",  ";

				result += SqlService.Convert(OffPercent) + ",  ";

				result += SqlService.Convert(CategoryId) + ",  ";

				result += SqlService.Convert(IsDeleted) + ",  ";

				result += SqlService.Convert(ModifyDate) + " ";


            return result;
        }
    }
}
