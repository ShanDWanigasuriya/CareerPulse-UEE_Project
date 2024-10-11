using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coreer_pulse_core_web_api.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class EventController : ControllerBase
	{

		private readonly IEventService _eventService;

		public EventController(IEventService eventService)
		{
			_eventService = eventService;
		}

		[HttpPost("CreateEvent")]
		public async Task<IActionResult> CreateEvent([FromForm] Event eventss)
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
			if (eventss.EventDocument != null && eventss.EventDocument.Length > 0)
			{
				var FolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Event");

				var FileName = projectGlobalIdentity.ToString() + "-" + eventss.EventDocument.FileName;
				var tFilePath = Path.Combine(FolderPath, FileName);

				using (var stream = new FileStream(tFilePath, FileMode.Create))
				{
					await eventss.EventDocument.CopyToAsync(stream);
				}

				FileUri = Path.Combine("/Uploads/Event", FileName).Replace("\\", "/");
			}

			eventss.EventDocumentUrl = FileUri;

			var status = await _eventService.CreateEvent(eventss);

			if (!status)
			{
				return Ok(status);
			}

			return StatusCode(201, status);
		}

		[HttpGet("GetAllEvents")]
		public async Task<IActionResult> GetAllEvents()
		{
			var mentorships = await _eventService.GetAllEvents();
			return Ok(mentorships);
		}

		[HttpGet("GetEventById")]
		public async Task<IActionResult> GetEventById(int eventId)
		{
			var mentorship = await _eventService.GetEventById(eventId);
			return Ok(mentorship);
		}
	}
}
