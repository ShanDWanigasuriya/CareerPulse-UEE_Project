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
    public class Event
    {
        public int? EventId { get; set; }
        public int? PostedMemberId { get; set; }
        public string? EventTitle { get; set; } = string.Empty;
        public string? EventDescription { get; set; } = string.Empty;
        public string? EventVenueEnm { get; set; } = string.Empty;
		public string? EventLink { get; set; } = string.Empty;
        public string? EventImageUrl { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string? EventDocumentUrl { get; set; } = string.Empty;
        [DefaultValue("true")]
        public bool IsPublic { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }

        [NotMapped]
        public IFormFile? EventDocument { get; set; }
    }
}
