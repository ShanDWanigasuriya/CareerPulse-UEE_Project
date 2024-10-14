using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coreer_pulse_core_web_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WelcomeController : ControllerBase
    {
        [HttpGet("HelloWorld")]
        public async Task<IActionResult> HelloWorld()
        {
            return Ok(new {message = "Hello World"});
        }

        [HttpGet("CareerPulse")]
        public async Task<IActionResult> CareerPulse()
        {
            return Ok(new { message = "Hello Career Pulse" });
        }

        [HttpGet("MultipleReturn")]
        public async Task<IActionResult> MultipleReturn()
        {
            var (asd,sad) = await get();
            return Ok();
        }


		public Task<(string, int)> get()
		{
			return Task.FromResult(("hi", 10));
		}
	}
}
