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
        public int CollaboratorId { get; set; }
        public string MentorshipTitle { get; set; } = string.Empty;
        public string MentorshipDescription { get; set; } = string.Empty;
        public string MentorName { get; set; } = string.Empty;
        public string MentorDescription { get; set; } = string.Empty;
        public string MentorExperience { get; set; } = string.Empty;
        public string MentorExpertise { get; set; } = string.Empty;
        public string? MentorDocumentUrl { get; set; } = string.Empty;
        [DefaultValue("true")]
        public bool IsPublic { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }
		[DefaultValue("true")]
		public bool IsAvailable { get; set; }
		public Guid? MentorshipGlobalIdentity { get; set; }

        [NotMapped]
        public IFormFile? MentorDocument { get; set; }

        #region NAVIGATIONAL PROPERTIES
        public ICollection<TimeSlot> TimeSlots { get; set; } = new List<TimeSlot>();
		#endregion

	}
}
