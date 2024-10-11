using bank_data_web_business_layer.Interfaces;
using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_model;
using career_pulse_core_repository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace career_pulse_core_business_layer
{
    public class ProjectServiceImpl : IProjectService
    {
        private readonly IDatabaseService _databaseService;
        public readonly ProjectRepository<Project> _projectRepository;

        public ProjectServiceImpl(IDatabaseService databaseService)
        {
            _databaseService = databaseService;
            _projectRepository = new ProjectRepository<Project>(_databaseService.GetConnectionString());
        }

        public async Task<bool> CreateProject(Project project)
        {
            string projectJsonString = JsonConvert.SerializeObject(project);
            bool status = _projectRepository.InsertData("CreateProject", projectJsonString);
            return status;
        }

        public async Task<IEnumerable<Project>> GetAllProjects()
        {
            var projects = _projectRepository.RetrieveData("GetAllProjects");
            return projects;
        }

        public async Task<Project> GetProjectById(int projectId)
        {
            var project = _projectRepository.RetrieveData("GetProjectById", new SqlParameter[]
            {
                new SqlParameter("@projectId", projectId)
            }).FirstOrDefault();

            return project;
        }
    }
}
