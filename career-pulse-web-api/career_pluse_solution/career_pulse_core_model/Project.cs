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
    public class Project
    {
        public int? ProjectId { get; set; }
        public int CollaboratorId { get; set; }
        public string ProjectName { get; set; } = string.Empty;
        public string ProjectDescription { get; set; } = string.Empty;
        public ProjectStatusEnum ProjectStatusEnum { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string? ProjectDocumentUrl { get; set; } = string.Empty;
        [DefaultValue("true")]
        public bool IsPublic { get; set; }
        [DefaultValue("false")]
        public bool IsDeleted { get; set; }
        public Guid? ProjectGlobalIdentity { get; set; }

        [NotMapped]
        public IFormFile? ProjectDocument { get; set; }
    }
}
