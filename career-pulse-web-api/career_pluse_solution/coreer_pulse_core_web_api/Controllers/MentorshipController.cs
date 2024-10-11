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
            string mentorshipImageFileUri = string.Empty;

            //store profile image
            if (mentorship.MentorshipImage != null && mentorship.MentorshipImage.Length > 0)
            {
                var mentorshipImagesFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Mentorship");

                var mentorshipImageFileName = mentorshipGlobalIdentity.ToString() + "-" + mentorship.MentorshipImage.FileName;
                var mentorshipImageFilePath = Path.Combine(mentorshipImagesFolderPath, mentorshipImageFileName);

                using (var stream = new FileStream(mentorshipImageFilePath, FileMode.Create))
                {
                    await mentorship.MentorshipImage.CopyToAsync(stream);
                }

                mentorshipImageFileUri = Path.Combine("/Uploads/Mentorship", mentorshipImageFileName).Replace("\\", "/");
            }

            mentorship.MentorshipImageUrl = mentorshipImageFileUri;
            mentorship.MentorshipGlobalIdentity = mentorshipGlobalIdentity;

            var status = await _mentorshipService.CreateMentorship(mentorship);
            return Ok(status);
        }
    }
}
