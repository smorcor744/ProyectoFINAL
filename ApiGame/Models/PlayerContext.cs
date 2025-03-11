using Microsoft.EntityFrameworkCore;
namespace ApiGame.Models;

public class PlayerContext : DbContext
{
    public PlayerContext(DbContextOptions<PlayerContext> options)
        : base(options)
    {
    }

    public DbSet<Player> Players { get; set; } = null!;
}