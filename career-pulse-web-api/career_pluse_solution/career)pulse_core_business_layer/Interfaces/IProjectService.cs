﻿using career_pulse_core_model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer.Interfaces
{
    public interface IProjectService
    {
        Task<bool> CreateProject(Project project);
        Task<IEnumerable<Project>> GetAllProjects();
        Task<Project> GetProjectById(int projectId);
    }
}
