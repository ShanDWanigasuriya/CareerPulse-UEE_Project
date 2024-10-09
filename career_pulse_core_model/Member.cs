using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_model
{
    public class Member
    {
        public int MemberId { get; set; }
        public string UserName { get; set; }  = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string? PasswordSalt { get; set; } = string.Empty;
        public int ActivationCode { get; set; }
        public MemberTypeEnum MemberTypeEnum { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string? ProfileImageUrl { get; set; } = string.Empty;
        public DateTime? CreatedDate { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }
        [DefaultValue("true")]
        public bool IsActive { get; set; }
        public Guid? MemberGlobalIdentity { get; set; }

        [NotMapped]
        public IFormFile? ProfileImage { get; set; }
    }
}
