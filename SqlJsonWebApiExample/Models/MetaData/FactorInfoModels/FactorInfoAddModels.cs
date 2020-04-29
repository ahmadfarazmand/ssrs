namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class FactorInfoAdd : BaseSqlAddParam
    {
		
		//[Column(Order = 2)]
		//[Timestamp]
		//[Required]
		//[MaxLength(50) , MinLength(1)]
		//[StringLength (50)]
		public string PhoneNumber { get; set; }

		//[Column(Order = 3)]
		//[Timestamp]
		//[Required]
		//[MaxLength(50) , MinLength(1)]
		//[StringLength (50)]
		public string ZipCode { get; set; }

		//[Column(Order = 4)]
		//[Timestamp]
		//[Required]
		//[MaxLength(150) , MinLength(1)]
		//[StringLength (150)]
		public string Address1 { get; set; }

		//[Column(Order = 5)]
		//[Timestamp]
		//[Required]
		//[MaxLength(150) , MinLength(1)]
		//[StringLength (150)]
		public string Address2 { get; set; }

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

            
				result += SqlService.Convert(PhoneNumber) + ",  ";

				result += SqlService.Convert(ZipCode) + ",  ";

				result += SqlService.Convert(Address1) + ",  ";

				result += SqlService.Convert(Address2) + ",  ";

				result += SqlService.Convert(IsDeleted) + ",  ";

				result += SqlService.Convert(ModifyDate) + ",  ";

				result += SqlService.Convert(SubmitDate) + " ";


            return result;
        }
    }
}
