namespace SqlJsonWebApiExample.Models.MetaData
{
	using Bases;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class LoginInfoFilter : BaseSqlFilterParam
    {
		
		public long? Id { get; set; }
		public string MultiText_Id { get; set; }
		public long? MinId { get; set; }
		public long? MaxId { get; set; }

		public string Username { get; set; }
		public string MultiText_Username { get; set; }

		public string Password { get; set; }
		public string MultiText_Password { get; set; }

		public long? UserInfoId { get; set; }
		public string MultiText_UserInfoId { get; set; }
		public long? MinUserInfoId { get; set; }
		public long? MaxUserInfoId { get; set; }

		public long? RoleId { get; set; }
		public string MultiText_RoleId { get; set; }
		public long? MinRoleId { get; set; }
		public long? MaxRoleId { get; set; }

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

			result += SqlService.Convert(Username) + ", ";

			result += SqlService.Convert(MultiText_Username) + ",  ";


			result += SqlService.Convert(Password) + ", ";

			result += SqlService.Convert(MultiText_Password) + ",  ";


			result += SqlService.Convert(UserInfoId) + ", ";
			result += SqlService.Convert(MultiText_UserInfoId) + ", ";
			result += SqlService.Convert(MinUserInfoId) + ", ";
			result += SqlService.Convert(MaxUserInfoId) + ",  ";

			result += SqlService.Convert(RoleId) + ", ";
			result += SqlService.Convert(MultiText_RoleId) + ", ";
			result += SqlService.Convert(MinRoleId) + ", ";
			result += SqlService.Convert(MaxRoleId) + ",  ";

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
