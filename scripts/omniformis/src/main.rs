use clap::{Parser, Subcommand};

mod bezier;
mod hypr;
mod qs;
mod theme;
mod utils;

#[derive(Parser)]
#[command(name = "omniformis", about = "Unified configuration CLI", version)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Manage themes
    Theme {
        #[command(subcommand)]
        cmd: ThemeCommands,
    },
    /// Quickshell management
    Qs {
        #[command(subcommand)]
        cmd: QsCommands,
    },
    /// Bezier preset management
    Bezier {
        #[command(subcommand)]
        cmd: BezierCommands,
    },
    /// Hyprland variables management
    Hypr {
        /// List all variables and their possible states
        #[arg(short, long)]
        list: bool,

        /// Additional arguments for hypr variables
        #[arg(trailing_var_arg = true, allow_hyphen_values = true)]
        args: Vec<String>,
    },
}

#[derive(Subcommand)]
enum ThemeCommands {
    /// Generate theme from QML files
    Generate {
        light_file: String,
        dark_file: String,
    },
    /// List available themes
    List,
    /// Toggle between light and dark mode
    Toggle,
}

#[derive(Subcommand)]
enum QsCommands {
    /// Get a QS variable
    Get { key: String },
    /// Set a QS variable
    Set { key: String, value: String },
    /// List QS variables
    List,
    /// Kill Quickshell processes
    Kill,
    /// Start Quickshell
    Start {
        #[arg(short, long)]
        detached: bool,
    },
}

#[derive(Subcommand)]
enum BezierCommands {
    /// Save current custom curves as a preset
    Save {
        name: String,
        #[arg(long)]
        payload: Option<String>,
    },
    /// Load a bezier preset
    Load { name: String },
    /// List available bezier presets
    List,
}

fn main() {
    let cli = Cli::parse();

    match cli.command {
        Commands::Theme { cmd } => match cmd {
            ThemeCommands::Generate {
                light_file,
                dark_file,
            } => theme::generate(&light_file, &dark_file),
            ThemeCommands::List => theme::list(),
            ThemeCommands::Toggle => theme::toggle(),
        },
        Commands::Qs { cmd } => match cmd {
            QsCommands::Get { key } => qs::get(&key),
            QsCommands::Set { key, value } => qs::set(&key, &value),
            QsCommands::List => qs::list(),
            QsCommands::Kill => qs::kill(),
            QsCommands::Start { detached } => qs::start(detached),
        },
        Commands::Bezier { cmd } => match cmd {
            BezierCommands::Save { name, payload } => bezier::save(&name, payload),
            BezierCommands::Load { name } => bezier::load(&name),
            BezierCommands::List => bezier::list(),
        },
        Commands::Hypr { list, args } => hypr::handle(list, args),
    }
}
