@echo off
for %%G in (1K, 1M, 1G) do (
 REM for %%F in (10,10_000,100_000) do (
 for %%F in (100,, 300,600) do (
    hyperfine --warmup 3 ^
      --export-markdown "./benches/remove_%%F_files_%%G_bytes.md" ^
      --export-json "./benches/remove_%%F_files_%%G_bytes.json" ^
      --prepare "ftzz g -n %%F -b %%G D:/tmp/ftzz" ^
        "rmdir /S /Q ""D:/tmp""" ^
        "D:/Repositories/fuc/target/release/rm_stdlib D:/tmp/ftzz" ^
        "D:/Repositories/fuc//target/release/rm_rayon D:/tmp/ftzz" ^
        "D:/Repositories/fuc//target/release/rm_remove_dir_all D:/tmp/ftzz" ^
        "D:/Repositories/fuc//target/release/rmz D:/tmp/ftzz"
    )

  hyperfine --warmup 3 ^
    --export-markdown "benches/remove_100_000_files_%%G_bytes_0_depth.md" ^
    --export-json "benches/remove_100_000_files_%%G_bytes_0_depth.json" ^
    --prepare "ftzz g -n 100_000 -b %%G -d 0 D:/tmp/ftzz" ^
      "rmdir /S /Q ""D:/tmp""" ^
      "D:/Repositories/fuc/target/release/rm_stdlib D:/tmp/ftzz" ^
      "D:/Repositories/fuc/target/release/rm_rayon D:/tmp/ftzz" ^
      "D:/Repositories/fuc/target/release/rm_remove_dir_all D:/tmp/ftzz" ^
      "D:/Repositories/fuc/target/release/rmz D:/tmp/ftzz"

  hyperfine --warmup 3 ^
    --export-markdown "benches/remove_100_000_files_%%G_bytes_5_files_per_dir.md" ^
    --export-json "benches/remove_100_000_files_%%G_bytes_5_files_per_dir.json" ^
    --prepare "ftzz g -n 100_000 -b %%G -r 5 D:/tmp/ftzz" ^
      "rmdir /S /Q ""D:/tmp""" ^
      "D:/Repositories/fuc/target/release/rm_stdlib ""D:/tmp/ftzz""" ^
      "D:/Repositories/fuc/target/release/rm_rayon ""D:/tmp/ftzz""" ^
      "D:/Repositories/fuc/target/release/rm_remove_dir_all ""D:/tmp/ftzz""" ^
      "D:/Repositories/fuc/target/release/rmz ""D:/tmp/ftzz"""
)