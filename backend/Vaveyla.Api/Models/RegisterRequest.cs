using System.ComponentModel.DataAnnotations;

namespace Vaveyla.Api.Models;

public sealed class RegisterRequest
{
    [Required]
    [MaxLength(120)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [MaxLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [MinLength(6)]
    [MaxLength(100)]
    public string Password { get; set; } = string.Empty;

    [Required]
    [Range(1, 3)]
    public int RoleId { get; set; }
}
