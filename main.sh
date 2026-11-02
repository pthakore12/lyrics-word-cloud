#!/bin/bash
cd "$(dirname "$0")" || exit 1
source lib/functions.sh
case "${1:-}" in
  --help) show_help; exit 0 ;;
  --backup) do_backup; exit $? ;;
  --cron) cron_task; exit $? ;;
esac
while true; do
  echo
  echo "========== LYRICS WORD CLOUD =========="
  echo "1) Top 10 words across all songs"
  echo "2) Line and word count per song"
  echo "3) Find which songs contain a word"
  echo "4) Replace a word in a song"
  echo "5) Save a word-frequency report"
  echo "6) View lyrics data"
  echo "7) Backup data (tar.gz)"
  echo "8) View activity log"
  echo "0) Exit"
  read -r -p "Choose an option: " ch
  case "$ch" in
    1) feature_1 ;; 2) feature_2 ;; 3) feature_3 ;;
    4) feature_4 ;; 5) feature_5 ;; 6) view_data ;;
    7) do_backup ;; 8) view_log ;; 0) echo "Bye!"; break ;;
    *) echo "Invalid choice, try again." ;;
  esac
done

