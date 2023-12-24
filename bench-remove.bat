@echo off
for %%G in (0,1G) do (
 for %%F in (10,10_000,100_000,1M) do (
    hyperfine --warmup 3 ^
      --export-markdown "benches/remove_%%F_files_%%G_bytes.md" ^
      --export-json "benches/remove_%%F_files_%%G_bytes.json" ^
      --prepare "ftzz g -n %%F -b %%G ""D:/tmp/ftzz""" ^
        "rmdir /S /Q ""D:/tmp/""" ^
        "./target/release/rm_stdlib D:/tmp/ftzz" ^
        "./target/release/rm_rayon D:/tmp/ftzz" ^
        "./target/release/rm_remove_dir_all D:/tmp/ftzz" ^
        "./target/release/rmz D:/tmp/ftzz"
    )

  hyperfine --warmup 3 -N ^
    --export-markdown "benches/remove_100_000_files_%%G_bytes_0_depth.md" ^
    --export-json "benches/remove_100_000_files_%%G_bytes_0_depth.json" ^
    --prepare "ftzz g -n 100_000 -b %%G -d 0 ""D:/tmp/ftzz""" ^
      "rmdir /S /Q ""D:/tmp/""" ^
      "./target/release/rm_stdlib D:/tmp/ftzz" ^
      "./target/release/rm_rayon D:/tmp/ftzz" ^
      "./target/release/rm_remove_dir_all D:/tmp/ftzz" ^
      "./target/release/rmz D:/tmp/ftzz"

  hyperfine --warmup 3 -N ^
    --export-markdown "benches/remove_100_000_files_%%G_bytes_5_files_per_dir.md" ^
    --export-json "benches/remove_100_000_files_%%G_bytes_5_files_per_dir.json" ^
    --prepare "ftzz g -n 100_000 -b %%G -r 5 ""D:/tmp/ftzz""" ^
      "rmdir /S /Q ""D:/tmp/""" ^
      "./target/release/rm_stdlib ""D:/tmp/ftzz""" ^
      "./target/release/rm_rayon ""D:/tmp/ftzz""" ^
      "./target/release/rm_remove_dir_all ""D:/tmp/ftzz""" ^
      "./target/release/rmz ""D:/tmp/ftzz"""
)
```