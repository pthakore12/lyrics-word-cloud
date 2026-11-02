# L10 – Lyrics Word Cloud

Bash project for analyzing lyric text files.

## Run
```bash
chmod +x main.sh
./main.sh
```

Put your own plain-text song lyrics in `data/lyrics/` as `.txt` files. Use only lyrics you have permission to use.

## Options
1. Top 10 words
2. Lines and words per song
3. Search for a word
4. Replace a word
5. Save frequency report
6. View lyrics
7. Back up data
8. View activity log

## Command-line options
`./main.sh --help`, `./main.sh --backup`, `./main.sh --cron`

## Weekly cron example
`0 22 * * 0 cd "$HOME/linux_project/lyricscloud" && /bin/bash ./main.sh --cron >> logs/cron.log 2>&1`
