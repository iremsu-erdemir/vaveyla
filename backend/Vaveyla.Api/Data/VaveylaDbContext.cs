using Microsoft.EntityFrameworkCore;
using Vaveyla.Api.Models;

namespace Vaveyla.Api.Data;

public sealed class VaveylaDbContext : DbContext
{
    public VaveylaDbContext(DbContextOptions<VaveylaDbContext> options)
        : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var user = modelBuilder.Entity<User>();
        user.ToTable("Users");
        user.HasKey(x => x.UserId);
        user.Property(x => x.FullName).HasMaxLength(120).IsRequired();
        user.Property(x => x.Email).HasMaxLength(256).IsRequired();
        user.Property(x => x.PasswordHash).HasMaxLength(200).IsRequired();
        user.Property(x => x.Role)
            .HasConversion<byte>()
            .IsRequired();
        user.Property(x => x.CreatedAtUtc)
            .HasDefaultValueSql("SYSUTCDATETIME()")
            .IsRequired();
        user.HasIndex(x => x.Email).IsUnique();
    }
}
