fn main() {
    println!(
        "Rust version: {}",
        include_str!(concat!(env!("OUT_DIR"), "/rust-version.txt"))
    );
}
