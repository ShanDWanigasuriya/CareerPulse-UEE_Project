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
    public class Job
    {
        public int? JobId { get; set; }
        public int? PostedMemberId { get; set; }
        public string JobTitle { get; set; } = string.Empty;
        public string JobDecription { get; set; } = string.Empty;
        public string JobTypeEnum { get; set; } = string.Empty;
		public string? DocumentUrl { get; set; } = string.Empty;
        public string? JobImageUrl { get; set; } = string.Empty;
        [DefaultValue("true")]
        public bool IsPublic { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }

        [NotMapped]
        public IFormFile? Document { get; set; }
        [NotMapped]
        public IFormFile? JobImage { get; set; }
    }
}
