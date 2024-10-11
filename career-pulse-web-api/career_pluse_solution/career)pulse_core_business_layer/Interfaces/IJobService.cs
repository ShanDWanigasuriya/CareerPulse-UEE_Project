using career_pulse_core_model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace career_pulse_core_business_layer.Interfaces
{
	public interface IJobService
	{
		Task<bool> CreateJob(Job job);
		Task<IEnumerable<Job>> GetAllJobs();
		Task<Job> GetJobById(int JobId);
	}
}
