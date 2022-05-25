var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var app = builder.Build();

app.UseHttpsRedirection();

app.MapGet("/", (string? name) => $"Hello { (name != null ? name : "Anonymous Person") }!");

app.Run();
