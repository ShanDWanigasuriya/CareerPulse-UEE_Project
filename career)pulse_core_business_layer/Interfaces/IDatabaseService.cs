using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace bank_data_web_business_layer.Interfaces
{
    public interface IDatabaseService
    {
        bool SetConnectionString(string connectionString = "");
        string GetConnectionString();
    }
}
