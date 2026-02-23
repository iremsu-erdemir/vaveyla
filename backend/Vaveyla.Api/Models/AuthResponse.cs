namespace Vaveyla.Api.Models;

public sealed class AuthResponse
{
    public Guid UserId { get; init; }
    public UserRole Role { get; init; }
    public string FullName { get; init; } = string.Empty;
}
