use std::process::Command;

pub fn main() -> Result<(), Box<dyn std::error::Error>> {
    let output = Command::new("rustc").arg("--version").output()?;
    let out_dir = std::env::var("OUT_DIR")?;
    std::fs::write(format!("{out_dir}/rust-version.txt"), output.stdout)?;
    Ok(())
}
