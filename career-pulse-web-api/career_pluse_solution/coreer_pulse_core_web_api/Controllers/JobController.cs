using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coreer_pulse_core_web_api.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class JobController : ControllerBase
	{
		private readonly IJobService _jobService;
		public JobController(IJobService jobService)
		{
			_jobService = jobService;
		}

		[HttpPost("CreateJob")]
		public async Task<IActionResult> CreateJob([FromForm] Job job)
		{
			//validate the model
			if (!ModelState.IsValid)
			{
				return BadRequest(ModelState);
			}

			//create new guid for user
			var projectGlobalIdentity = Guid.NewGuid();
			string FileUri = string.Empty;

			//store profile image
			if (job.Document != null && job.Document.Length > 0)
			{
				var FolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Job");

				var FileName = projectGlobalIdentity.ToString() + "-" + job.Document.FileName;
				var tFilePath = Path.Combine(FolderPath, FileName);

				using (var stream = new FileStream(tFilePath, FileMode.Create))
				{
					await job.Document.CopyToAsync(stream);
				}

				FileUri = Path.Combine("/Uploads/Job", FileName).Replace("\\", "/");
			}

			job.DocumentUrl = FileUri;

			var status = await _jobService.CreateJob(job);

			if (!status)
			{
				return Ok(status);
			}

			return StatusCode(201, status);
		}

		[HttpGet("GetAllJobs")]
		public async Task<IActionResult> GetAllJobs()
		{
			var mentorships = await _jobService.GetAllJobs();
			return Ok(mentorships);
		}

		[HttpGet("GetJobById")]
		public async Task<IActionResult> GetJobById(int jobId)
		{
			var mentorship = await _jobService.GetJobById(jobId);
			return Ok(mentorship);
		}
	}
}
