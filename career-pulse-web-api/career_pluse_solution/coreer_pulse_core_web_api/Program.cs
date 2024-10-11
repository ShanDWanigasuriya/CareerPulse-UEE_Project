using bank_data_web_business_layer.Interfaces;
using bank_data_web_business_layer;
using career_pulse_core_business_layer.Interfaces;
using career_pulse_core_business_layer;
using Microsoft.Extensions.FileProviders;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.ConfigureSwaggerGen(setup =>
{
    setup.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Career Pulse",
        Version = "v1"
    });
});

#region Database Service
var configuration = builder.Configuration;
var connectionString = configuration.GetConnectionString("databaseconnection");
builder.Services.AddSingleton<IDatabaseService>(provider =>
{
    var dbService = new DatabaseServiceImpl();
    dbService.SetConnectionString(connectionString);
    return dbService;
});
#endregion

#region Services
builder.Services.AddSingleton<IMemberService, MemberServiceImpl>();
builder.Services.AddSingleton<IMentorshipService, MentorshipServiceImpl>();
builder.Services.AddSingleton<IProjectService, ProjectServiceImpl>();
builder.Services.AddSingleton<IJobService, JobServiceImpl>();
builder.Services.AddSingleton<IEventService, EventServiceImpl>();
#endregion

var app = builder.Build();

app.UseSwagger();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory(), "Uploads")),
    RequestPath = "/Uploads"
});

app.UseAuthorization();

app.MapControllers();

app.Run();
