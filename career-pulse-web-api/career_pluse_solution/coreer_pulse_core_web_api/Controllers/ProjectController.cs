using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coreer_pulse_core_web_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectController : ControllerBase
    {
        private readonly IProjectService _projectService;
        public ProjectController(IProjectService projectService)
        {
            _projectService = projectService;
        }

        [HttpPost("CreateProject")]
        public async Task<IActionResult> CreateProject([FromForm] Project project)
        {
            //validate the model
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            //create new guid for user
            var projectGlobalIdentity = Guid.NewGuid();
            string projectFileUri = string.Empty;

            //store profile image
            if (project.ProjectDocument != null && project.ProjectDocument.Length > 0)
            {
                var projectFolderPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Project");

                var projectFileName = projectGlobalIdentity.ToString() + "-" + project.ProjectDocument.FileName;
                var projectFilePath = Path.Combine(projectFolderPath, projectFileName);

                using (var stream = new FileStream(projectFilePath, FileMode.Create))
                {
                    await project.ProjectDocument.CopyToAsync(stream);
                }

                projectFileUri = Path.Combine("/Uploads/Project", projectFileName).Replace("\\", "/");
            }

            project.ProjectGlobalIdentity = projectGlobalIdentity;
            project.ProjectDocumentUrl = projectFileUri;

            var status = await _projectService.CreateProject(project);

            if (!status)
            {
                return Ok(status);
            }

            return StatusCode(201, status);
        }

        [HttpGet("GetAllProjects")]
        public async Task<IActionResult> GetAllProjects()
        {
            var projects = await _projectService.GetAllProjects();

            if(projects == null)
            {
                return NotFound("Projects Not Found");
            }

            return Ok(projects);
        }

        [HttpGet("GetProjectById")]
        public async Task<IActionResult> GetProjectById(int projectId)
        {
            var project = await _projectService.GetProjectById(projectId);

            if (project == null)
            {
                return NotFound("Project Not Found");
            }

            return Ok(project);
        }
    }
}
