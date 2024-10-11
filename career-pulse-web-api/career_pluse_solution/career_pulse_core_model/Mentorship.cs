using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_model
{
    public class Mentorship
    {
        public int MentorshipId { get; set; }
        public int MentorId { get; set; }
        public string MentorshipTitle { get; set; } = string.Empty;
        public string MentorshipDescription { get; set; } = string.Empty;
        public MentorshipTypeEnum MentorshipTypeEnum { get; set; }
        public string MentorshipImageUrl { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        [DefaultValue("true")]
        public bool IsPublic { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }
        public Guid MentorshipGlobalIdentity { get; set; }

        [NotMapped]
        public IFormFile? MentorshipImage { get; set; }

    }
}
