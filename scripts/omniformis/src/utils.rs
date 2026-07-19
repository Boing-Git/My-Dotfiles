use std::path::{Path, PathBuf};

pub fn expand_tilde<P: AsRef<Path>>(path: P) -> PathBuf {
    let p = path.as_ref();
    if !p.starts_with("~") {
        return p.to_path_buf();
    }
    
    let mut expanded = dirs::home_dir().unwrap_or_else(|| PathBuf::from("/"));
    if p != Path::new("~") {
        expanded.push(p.strip_prefix("~").unwrap());
    }
    expanded
}
