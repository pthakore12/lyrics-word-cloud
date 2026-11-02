#!/bin/bash
DATA_DIR="data/lyrics"
REPORT_DIR="reports"
BACKUP_DIR="backups"
LOG="logs/activity.log"

log() { printf '%s | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG"; }
check_data() {
  if [ ! -d "$DATA_DIR" ] || ! find "$DATA_DIR" -maxdepth 1 -type f -name '*.txt' -print -quit | grep -q .; then
    echo "No .txt lyric files found in $DATA_DIR"; return 1
  fi
}
show_help() {
  echo "./main.sh            Open the menu"
  echo "./main.sh --help     Show help"
  echo "./main.sh --backup   Back up data"
  echo "./main.sh --cron     Rebuild the word-frequency report"
}
view_data() {
  check_data || return
  for file in "$DATA_DIR"/*.txt; do [ -f "$file" ] && { echo; echo "=== $file ==="; cat -n "$file"; }; done
  log "viewed lyrics data"
}
do_backup() {
  mkdir -p "$BACKUP_DIR"
  local f="$BACKUP_DIR/data_$(date +%Y%m%d_%H%M%S).tar.gz"
  if tar -czf "$f" data/; then echo "Backup saved: $f ($(du -h "$f" | cut -f1))"; log "backup created $f"; else echo "Backup failed"; return 1; fi
}
view_log() { if [ -f "$LOG" ]; then tail -n 15 "$LOG"; else echo "No activity yet."; fi; }
word_stream() {
  find "$DATA_DIR" -maxdepth 1 -type f -name '*.txt' -print0 |
    xargs -0 -r cat -- | tr '[:upper:]' '[:lower:]' |
    tr -cs '[:alpha:]' '\n' | sed '/^$/d'
}
feature_1() {
  check_data || return
  echo "== Top 10 words across all songs =="
  word_stream | sort | uniq -c | sort -nr | head -10
  log "feature_1 top words"
}
feature_2() {
  check_data || return
  echo "== Line and word count per song =="
  for file in "$DATA_DIR"/*.txt; do
    [ -f "$file" ] || continue
    echo "$file"; printf 'Lines: '; wc -l < "$file"; printf 'Words: '; wc -w < "$file"
  done
  log "feature_2 counts"
}
feature_3() {
  check_data || return
  read -r -p "Enter a word to search for: " word
  [ -n "$word" ] || { echo "Please enter a word."; return; }
  echo "Songs containing '$word':"
  grep -rilw --include='*.txt' -- "$word" "$DATA_DIR" || echo "No matching songs found."
  log "feature_3 searched for $word"
}
feature_4() {
  check_data || return
  echo "Available songs:"; find "$DATA_DIR" -maxdepth 1 -type f -name '*.txt' -printf '%f\n'
  read -r -p "Enter song filename (e.g. song1.txt): " filename
  case "$filename" in ""|*/*|*..*) echo "Invalid filename."; return ;; esac
  local file="$DATA_DIR/$filename"
  [ -f "$file" ] || { echo "Song not found."; return; }
  read -r -p "Word to replace: " old
  read -r -p "Replace it with: " new
  [ -n "$old" ] || { echo "Search word cannot be empty."; return; }
  local old_escaped new_escaped
  old_escaped=$(printf '%s' "$old" | sed 's/[\/&]/\\&/g')
  new_escaped=$(printf '%s' "$new" | sed 's/[\/&]/\\&/g')
  sed -i "s/$old_escaped/$new_escaped/gI" "$file"
  echo "Replacement complete in $filename."
  log "feature_4 replaced '$old' with '$new' in $filename"
}
generate_report() {
  mkdir -p "$REPORT_DIR"
  local output="${1:-$REPORT_DIR/word_frequency.txt}"
  { echo "LYRICS WORD FREQUENCY REPORT"; echo "Generated: $(date)"; echo; echo "Count  Word"; word_stream | sort | uniq -c | sort -nr; } > "$output"
}
feature_5() {
  check_data || return
  generate_report
  echo "Report saved to reports/word_frequency.txt"
  log "feature_5 generated report"
}
cron_task() {
  check_data || return
  generate_report "$REPORT_DIR/word_frequency.txt"
  printf '%s cron task ran; report rebuilt\n' "$(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_DIR/cron_output.txt"
  log "cron task rebuilt report"
  echo "Scheduled-task action completed."
}
