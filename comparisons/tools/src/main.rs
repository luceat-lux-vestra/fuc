use std::{env, fs, fs::File, io::Read};

const ORDER: &[&str] = &["1M_files", "100_000_files", "10_000_files", "10_files"];

fn main() {
    let mut v = Vec::new();
    for entry in fs::read_dir(env::args_os().last().unwrap()).unwrap() {
        let entry = entry.unwrap();
        if !entry.file_name().to_string_lossy().ends_with(".md") {
            continue;
        }

        v.push(entry);
    }

    v.sort_by(|a, b| {
        fn index(s: &str) -> usize {
            ORDER
                .iter()
                .enumerate()
                .find_map(|(i, target)| s.find(target).map(|_| i))
                .unwrap()
        }

        let a = a.file_name().to_string_lossy().into_owned();
        let b = b.file_name().to_string_lossy().into_owned();

        index(&a).cmp(&index(&b)).then(a.cmp(&b))
    });
    for entry in v {
        println!("#### `{}`", entry.file_name().to_string_lossy());

        let mut s = String::new();
        File::open(entry.path())
            .unwrap()
            .read_to_string(&mut s)
            .unwrap();
        let s = s
            .replace(
                "`./target/release/rmz /tmp/ftzz`",
                "*`./target/release/rmz /tmp/ftzz`*",
            )
            .replace(
                "`./target/release/cpz /tmp/ftzz /tmp/ftzzz`",
                "*`./target/release/cpz /tmp/ftzz /tmp/ftzzz`*",
            );
        println!("{s}");
    }
}
