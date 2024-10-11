using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coreer_pulse_core_web_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MentorshipController : ControllerBase
    {
        private readonly IMentorshipService _mentorshipService;
        public MentorshipController(IMentorshipService mentorshipService)
        {
            _mentorshipService = mentorshipService; 
        }

        [HttpPost("CreateMentorship")]
        public async Task<IActionResult> CreateMentorship([FromForm] Mentorship mentorship)
        {
            //validate the model
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            //create new guid for user
            var mentorshipGlobalIdentity = Guid.NewGuid();
            string mentorDocumentFileUri = string.Empty;

            //store profile image
            if (mentorship.MentorDocument != null && mentorship.MentorDocument.Length > 0)
            {
                var mentorDocumentFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Mentorship");

                var mentorDocumentFileName = mentorshipGlobalIdentity.ToString() + "-" + mentorship.MentorDocument.FileName;
                var mentorDocumentFilePath = Path.Combine(mentorDocumentFolderPath, mentorDocumentFileName);

                using (var stream = new FileStream(mentorDocumentFilePath, FileMode.Create))
                {
                    await mentorship.MentorDocument.CopyToAsync(stream);
                }

				mentorDocumentFileUri = Path.Combine("/Uploads/Mentorship", mentorDocumentFileName).Replace("\\", "/");
            }

            mentorship.MentorDocumentUrl = mentorDocumentFileUri;
            mentorship.MentorshipGlobalIdentity = mentorshipGlobalIdentity;

            var status = await _mentorshipService.CreateMentorship(mentorship);
            return StatusCode(201, status);
        }

        [HttpGet("GetAllMentorships")]
        public async Task<IActionResult> GetAllMentorships()
        {
            var mentorships = await _mentorshipService.GetAllMentorships();
            return Ok(mentorships);
        }

		[HttpGet("GetMentorshipsById")]
		public async Task<IActionResult> GetMentorshipsById(int mentorshipId)
		{
			var mentorship = await _mentorshipService.GetMentorshipsById(mentorshipId);
			return Ok(mentorship);
		}

	}
}
