@echo off

REM First for loop handling num_bytes
FOR %%G IN (1K, 1M, 1G) DO (
    REM Second for loop handling num_files
    REM FOR %%F IN (10, 10_000, 100_000) DO (
    FOR %%F IN (100, 300, 600) DO (
        hyperfine --warmup 3 --show-output -i ^
          --export-markdown "./benches/copy_%%F_files_%%G_bytes.md" ^
          --export-json "./benches/copy_%%F_files_%%G_bytes.json" ^
          --setup "ftzz g -n %%F -b %%G D:/tmp/ftzz" ^
          --prepare "rm -rf D:/tmp/ftzzz" --cleanup "rm -r D:/tmp/ftzz" ^
            "robocopy D:/tmp/ftzz D:/tmp/ftzzz /LOG:NUL /MIR /NP /MT:64" ^
            "D:/Repositories/fuc/target/release/cp_rayon D:/tmp/ftzz D:/tmp/ftzzz" ^
            "D:/Repositories/fuc/target/release/cpz D:/tmp/ftzz D:/tmp/ftzzz"
      )

      hyperfine --warmup 3 --show-output -i ^
        --export-markdown "./benches/copy_1000_files_%%G_bytes_0_depth.md" ^
        --export-json "./benches/copy_1000_files_%%G_bytes_0_depth.json" ^
        --setup "ftzz g -n 1000 -b %%G -d 0 D:/tmp/ftzz" ^
        --prepare "rm -rf D:/tmp/ftzzz" --cleanup "rm -r D:/tmp/ftzz" ^
          "robocopy D:/tmp/ftzz D:/tmp/ftzzz /LOG:NUL /MIR /NP /MT:64" ^
          "D:/Repositories/fuc/target/release/cp_rayon D:/tmp/ftzz D:/tmp/ftzzz" ^
          "D:/Repositories/fuc/target/release/cpz D:/tmp/ftzz D:/tmp/ftzzz"

      hyperfine --warmup 3 --show-output -i ^
        --export-markdown "./benches/copy_1000_files_%%G_bytes_5_files_per_dir.md" ^
        --export-json "./benches/copy_1000_files_%%G_bytes_5_files_per_dir.json" ^
        --setup "ftzz g -n 1000 -b %%G -r 5 D:/tmp/ftzz" ^
        --prepare "rm -rf D:/tmp/ftzzz" --cleanup "rm -r D:/tmp/ftzz" ^
          "robocopy D:/tmp/ftzz D:/tmp/ftzzz /LOG:NUL /MIR /NP /MT:64" ^
          "D:/Repositories/fuc/target/release/cp_rayon D:/tmp/ftzz D:/tmp/ftzzz" ^
          "D:/Repositories/fuc/target/release/cpz D:/tmp/ftzz D:/tmp/ftzzz"
    )

    hyperfine --warmup 3 --show-output -i ^
      --export-markdown "./benches/copy_1000_files_1G_bytes_0_depth_0_entropy.md" ^
      --export-json "./benches/copy_1000_files_1G_bytes_0_depth_0_entropy.json" ^
      --setup "ftzz g -n 1000 -b 1G -d 0 --fill-byte 0 D:/tmp/ftzz" ^
      --prepare "rm -rf D:/tmp/ftzzz" --cleanup "rm -r D:/tmp/ftzz" ^
        "robocopy D:/tmp/ftzz D:/tmp/ftzzz /LOG:NUL /MIR /NP /MT:64" ^
        "D:/Repositories/fuc/target/release/cp_rayon D:/tmp/ftzz D:/tmp/ftzzz" ^
        "D:/Repositories/fuc/target/release/cpz D:/tmp/ftzz D:/tmp/ftzzz"