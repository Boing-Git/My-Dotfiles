use crate::utils::expand_tilde;
use crate::qs::{load_variables, parse_all, update_var, save_variables};
use crate::hypr::{read_file, write_file};
use regex::Regex;
use serde_json::Value;
use std::collections::HashMap;
use std::fs;
use std::process::exit;

fn get_presets_file() -> std::path::PathBuf {
    expand_tilde("~/.config/quickshell/bezier_presets.json")
}

pub fn save(name: &str, payload: Option<String>) {
    let variables = if let Some(p) = payload {
        serde_json::from_str::<HashMap<String, String>>(&p).unwrap_or_default()
    } else {
        let content = load_variables();
        parse_all(&content)
    };

    let mut preset = HashMap::new();
    let keys = [
        "customStandard", "customStandardDecelerate", "customStandardAccelerate",
        "customEmphasizedDecelerate", "customEmphasizedAccelerate",
        "customExpressiveSpatialFast", "customExpressiveSpatialSlow"
    ];

    for &k in &keys {
        if let Some(v) = variables.get(k) {
            preset.insert(k.to_string(), v.to_string());
        }
    }

    let presets_file = get_presets_file();
    let mut presets: HashMap<String, HashMap<String, String>> = HashMap::new();
    
    if presets_file.exists() {
        if let Ok(content) = fs::read_to_string(&presets_file) {
            if let Ok(p) = serde_json::from_str(&content) {
                presets = p;
            }
        }
    }

    presets.insert(name.to_string(), preset.clone());

    if let Some(parent) = presets_file.parent() {
        fs::create_dir_all(parent).unwrap();
    }
    fs::write(&presets_file, serde_json::to_string_pretty(&presets).unwrap()).unwrap();

    let lua_file = expand_tilde(format!("~/.config/hypr/modules/animations/{}.lua", name));
    let get_p = |k: &str, d: &str| -> String {
        preset.get(k).map(|s| s.trim_matches(|c| c == '[' || c == ']').to_string()).unwrap_or_else(|| d.to_string())
    };

    let lua_content = format!(
r#"local vars = require("modules.variables")

hl.config({{
    bezier = {{
        "customStandard, {}",
        "customStandardDecelerate, {}",
        "customStandardAccelerate, {}",
        "customEmphasizedDecelerate, {}",
        "customEmphasizedAccelerate, {}",
        "customExpressiveSpatialFast, {}",
        "customExpressiveSpatialSlow, {}"
    }},
    animation = {{
        "windows, 1, 4, customStandard",
        "windowsIn, 1, 4, customEmphasizedDecelerate, popin 80%",
        "windowsOut, 1, 3, customEmphasizedAccelerate, popin 80%",
        "border, 1, 5, customExpressiveSpatialSlow",
        "borderangle, 1, 8, customExpressiveSpatialSlow",
        "fade, 1, 3, customStandard",
        "workspaces, 1, 4, customExpressiveSpatialSlow, fade"
    }}
}})
"#,
        get_p("customStandard", "0.2, 0.0, 0.0, 1.0"),
        get_p("customStandardDecelerate", "0.0, 0.0, 0.0, 1.0"),
        get_p("customStandardAccelerate", "0.3, 0.0, 1.0, 1.0"),
        get_p("customEmphasizedDecelerate", "0.05, 0.7, 0.1, 1.0"),
        get_p("customEmphasizedAccelerate", "0.3, 0.0, 0.8, 0.15"),
        get_p("customExpressiveSpatialFast", "0.42, 1.67, 0.21, 0.9"),
        get_p("customExpressiveSpatialSlow", "0.39, 1.29, 0.35, 0.98")
    );

    fs::write(&lua_file, lua_content).unwrap();

    let var_content = read_file();
    let re = Regex::new(r"(?m)(--.*AnimateStyle.*\n\s*AnimateStyle\s*=\s*.*?,\s*--\s*)(.*?)\n").unwrap();
    if let Some(caps) = re.captures(&var_content) {
        let prefix = &caps[1];
        let enums_str = &caps[2];
        let mut enums: Vec<String> = enums_str.split(',').map(|s| s.trim().to_string()).collect();
        let name_quoted = format!("\"{}\"", name);
        if !enums.contains(&name_quoted) {
            enums.push(name_quoted);
            let joined = enums.join(", ");
            let repl = format!("{}{}\n", prefix, joined);
            let new_content = re.replace(&var_content, repl).to_string();
            write_file(&new_content);
        }
    }

    let mut qs_content = load_variables();
    for (k, v) in &preset {
        qs_content = update_var(&qs_content, k, v);
    }
    save_variables(&qs_content);

    println!("Saved bezier preset and generated Animation Style '{}'", name);
}

pub fn load(name: &str) {
    let presets_file = get_presets_file();
    if !presets_file.exists() {
        eprintln!("No presets found.");
        exit(1);
    }

    let content = fs::read_to_string(&presets_file).unwrap();
    let presets: HashMap<String, HashMap<String, String>> = serde_json::from_str(&content).unwrap_or_else(|_| {
        eprintln!("Error reading presets file.");
        exit(1);
    });

    if let Some(preset) = presets.get(name) {
        let mut content = load_variables();
        for (k, v) in preset {
            content = update_var(&content, k, v);
        }
        save_variables(&content);
        println!("Loaded bezier preset '{}'. (You may need to reload Quickshell)", name);
    } else {
        eprintln!("Preset '{}' not found.", name);
        exit(1);
    }
}

pub fn list() {
    let presets_file = get_presets_file();
    if !presets_file.exists() {
        println!("No presets found.");
        return;
    }

    if let Ok(content) = fs::read_to_string(&presets_file) {
        if let Ok(presets) = serde_json::from_str::<Value>(&content) {
            if let Some(obj) = presets.as_object() {
                println!("Available Bezier Presets:");
                for k in obj.keys() {
                    println!("  - {}", k);
                }
            }
        } else {
            eprintln!("Error reading presets file.");
        }
    }
}
