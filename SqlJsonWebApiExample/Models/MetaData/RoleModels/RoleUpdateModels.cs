namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class RoleUpdate : BaseSqlUpdateParam
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
		//[MaxLength(100) , MinLength(1)]
		//[StringLength (100)]
		public string Name { get; set; }

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

				result += SqlService.Convert(Name) + ",  ";

				result += SqlService.Convert(IsDeleted) + ",  ";

				result += SqlService.Convert(ModifyDate) + " ";


            return result;
        }
    }
}
