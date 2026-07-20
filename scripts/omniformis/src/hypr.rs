use crate::utils::expand_tilde;
use regex::Regex;
use std::collections::HashMap;
use std::fs;
use std::process::{Command, exit};

fn get_hypr_vars_file() -> std::path::PathBuf {
    expand_tilde("~/Dotfiles/hypr/modules/variables.lua")
}

pub fn read_file() -> String {
    let path = get_hypr_vars_file();
    fs::read_to_string(&path).unwrap_or_else(|_| {
        eprintln!("Error: {:?} not found.", path);
        exit(1);
    })
}

pub fn write_file(content: &str) {
    let path = get_hypr_vars_file();
    fs::write(path, content).expect("Failed to write to variables.lua");
}

#[derive(Debug)]
pub struct HyprVarInfo {
    pub val_type: String,
    pub help: String,
    pub enums: Vec<String>,
    pub val: String,
    pub category: String,
}

pub fn parse_variables(content: &str) -> HashMap<String, HyprVarInfo> {
    let mut variables = HashMap::new();
    let mut current_comments = Vec::new();
    let mut current_category = String::from("General");
    
    let pattern = Regex::new(r#"^([a-zA-Z0-9_]+)[ \t]*=[ \t]*(?:"([^"]*)"|(true|false)|(-?\d+(?:\.\d+)?))(?:,?[ \t]*(--.*)?)?$"#).unwrap();
    let enum_pattern = Regex::new(r#"\((.*)\)"#).unwrap();
    let quotes_pattern = Regex::new(r#""([^"]+)""#).unwrap();

    for line in content.lines() {
        let stripped = line.trim();
        if stripped.starts_with("--") && !stripped.starts_with("---") {
            let c = stripped.trim_start_matches('-').trim();
            current_comments.push(c.to_string());
        } else if stripped.is_empty() || stripped.starts_with("---") {
            current_comments.clear();
        } else if let Some(caps) = pattern.captures(stripped) {
            let key = caps.get(1).unwrap().as_str().to_string();
            let str_val = caps.get(2).map(|m| m.as_str());
            let bool_val = caps.get(3).map(|m| m.as_str());
            let num_val = caps.get(4).map(|m| m.as_str());
            let comment = caps.get(5).map(|m| m.as_str());

            if current_comments.len() > 1 {
                current_category = current_comments[0].clone();
            }

            let help_text = if let Some(c) = comment {
                c.trim_start_matches("- ").to_string()
            } else if let Some(last) = current_comments.last() {
                last.clone()
            } else {
                format!("Set {}", key)
            };

            let (val_type, current_val) = if let Some(v) = str_val {
                ("string", v.to_string())
            } else if let Some(v) = bool_val {
                ("bool", v.to_string())
            } else if let Some(v) = num_val {
                ("number", v.to_string())
            } else {
                current_comments.clear();
                continue;
            };

            if key == "ColorScheme" {
                current_comments.clear();
                continue;
            }

            let mut enums = Vec::new();
            if val_type == "string" {
                let mut comments_to_check = Vec::new();
                if let Some(c) = comment {
                    comments_to_check.push(c.to_string());
                }
                comments_to_check.extend(current_comments.clone());

                for c in comments_to_check {
                    if let Some(m) = enum_pattern.captures(&c) {
                        for q in quotes_pattern.captures_iter(&m[1]) {
                            enums.push(q[1].to_string());
                        }
                    }
                }
            }

            variables.insert(key, HyprVarInfo {
                val_type: val_type.to_string(),
                help: help_text,
                enums,
                val: current_val,
                category: current_category.clone(),
            });

            current_comments.clear();
        } else {
            current_comments.clear();
        }
    }
    variables
}

pub fn update_var(content: &str, key: &str, value: &str, val_type: &str) -> String {
    let re;
    let repl;
    
    if val_type == "string" {
        re = Regex::new(&format!(r#"(?m)^([ \t]*)({})([ \t]*=[ \t]*)"[^"]*"(,?[ \t]*(?:--.*)?)$"#, regex::escape(key))).unwrap();
        repl = format!("${{1}}${{2}}${{3}}\"{}\"${{4}}", value);
    } else if val_type == "bool" {
        let val_str = match value.to_lowercase().as_str() {
            "true" | "1" | "yes" | "y" | "t" => "true",
            _ => "false",
        };
        re = Regex::new(&format!(r"(?m)^([ \t]*)({})([ \t]*=[ \t]*)(true|false)(,?[ \t]*(?:--.*)?)$", regex::escape(key))).unwrap();
        repl = format!("${{1}}${{2}}${{3}}{}${{5}}", val_str);
    } else if val_type == "number" {
        let formatted = if let Ok(num) = value.parse::<f64>() {
            if num.fract() == 0.0 && !value.contains('.') {
                (num as i64).to_string()
            } else {
                num.to_string()
            }
        } else {
            value.to_string()
        };
        re = Regex::new(&format!(r"(?m)^([ \t]*)({})([ \t]*=[ \t]*)-?\d+(?:\.\d+)?(,?[ \t]*(?:--.*)?)$", regex::escape(key))).unwrap();
        repl = format!("${{1}}${{2}}${{3}}{}${{4}}", formatted);
    } else {
        return content.to_string();
    }

    let mut modified = false;
    let res = re.replace(content, |caps: &regex::Captures| {
        modified = true;
        let mut s = repl.clone();
        for i in 1..=5 {
            if let Some(m) = caps.get(i) {
                s = s.replace(&format!("${{{}}}", i), m.as_str());
            } else {
                s = s.replace(&format!("${{{}}}", i), "");
            }
        }
        s
    }).to_string();

    if modified {
        println!("Successfully updated {} to {}", key, value);
    } else {
        println!("Warning: Could not find or update {} in variables.lua", key);
    }
    res
}

pub fn list() {
    let content = read_file();
    let variables = parse_variables(&content);
    
    let exclude = [
        "CustomStandard", "CustomStandardDecelerate", "CustomStandardAccelerate",
        "CustomEmphasizedDecelerate", "CustomEmphasizedAccelerate",
        "CustomExpressiveSpatialFast", "CustomExpressiveSpatialSlow"
    ];

    let mut keys: Vec<_> = variables.keys().collect();
    keys.sort();
    for key in keys {
        if exclude.contains(&key.as_str()) {
            continue;
        }
        let info = &variables[key];
        let type_str = if info.val_type == "bool" {
            "togglable bool".to_string()
        } else if !info.enums.is_empty() {
            format!("enum ({})", info.enums.join(", "))
        } else {
            info.val_type.clone()
        };

        let left_part = format!("{}: {}", key, type_str);
        let val_part = format!("[{}]", info.val);
        println!("{:<50} {:<15} - {} | {}", left_part, val_part, info.category, info.help);
    }
}

pub fn get(key: &str) {
    let content = read_file();
    let variables = parse_variables(&content);
    if let Some(info) = variables.get(key) {
        println!("{}", info.val);
    } else {
        eprintln!("Variable {} not found", key);
        exit(1);
    }
}

pub fn set(key: &str, value: &str) {
    let mut content = read_file();
    let variables = parse_variables(&content);
    
    if let Some(info) = variables.get(key) {
        content = update_var(&content, key, value, &info.val_type);
        write_file(&content);
        if key == "GameMode" {
            let _ = Command::new("sh")
                .arg("-c")
                .arg("omniformis qs kill; sleep 0.1; omniformis qs start -d")
                .spawn();
        }
    } else {
        eprintln!("Warning: Unknown variable: {}", key);
        exit(1);
    }
}
