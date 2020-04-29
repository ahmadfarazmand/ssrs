namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class LoginInfoAdd : BaseSqlAddParam
    {
		
		//[Column(Order = 2)]
		//[Timestamp]
		//[Required]
		//[MaxLength(100) , MinLength(1)]
		//[StringLength (100)]
		public string Username { get; set; }

		//[Column(Order = 3)]
		//[Timestamp]
		//[Required]
		//[MaxLength(100) , MinLength(1)]
		//[StringLength (100)]
		public string Password { get; set; }

		//[Column(Order = 4)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public long? UserInfoId { get; set; }

		//[Column(Order = 5)]
		//[Timestamp]
		//[Required]
		//[MaxLength(0) , MinLength(1)]
		//[StringLength (0)]
		public long? RoleId { get; set; }

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

            
				result += SqlService.Convert(Username) + ",  ";

				result += SqlService.Convert(Password) + ",  ";

				result += SqlService.Convert(UserInfoId) + ",  ";

				result += SqlService.Convert(RoleId) + ",  ";

				result += SqlService.Convert(IsDeleted) + ",  ";

				result += SqlService.Convert(ModifyDate) + ",  ";

				result += SqlService.Convert(SubmitDate) + " ";


            return result;
        }
    }
}
