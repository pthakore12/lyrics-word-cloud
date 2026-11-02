# L10 – Lyrics Word Cloud

A Linux Bash project that analyzes song lyrics using command-line tools. It can count words, search lyrics, replace words, generate frequency reports, and back up lyric data.

## Features

1. **Top 10 Words** – Find the most frequently used words across all song files.
2. **Line and Word Count** – Display line and word counts for each song.
3. **Word Search** – Find which songs contain a particular word.
4. **Word Replacement** – Replace a word in a selected song.
5. **Frequency Report** – Save a report of word frequencies.
6. **View Lyrics** – Display the available lyric files.
7. **Data Backup** – Create a compressed `.tar.gz` backup of the data.
8. **Activity Log** – View recorded project activity.

## Technologies Used

- Bash scripting
- Linux command-line utilities
- Git and GitHub
- Ubuntu

## Project Structure

```text
lyrics-word-cloud/
├── main.sh
├── lib/
│   └── functions.sh
├── data/
│   └── lyrics/
│       ├── song1.txt
│       └── song2.txt
├── reports/
├── backups/
├── logs/
└── README.md
```

## Requirements

- Ubuntu or another Linux environment
- Bash
- Git (optional, for version control)

## Installation and Usage

Clone the repository:

```bash
git clone https://github.com/pthakore12/lyrics-word-cloud.git
cd lyrics-word-cloud
```

Make the main script executable and run it:

```bash
chmod +x main.sh
./main.sh
```

Follow the on-screen menu to choose a feature.

## Add Your Own Lyrics

Place plain-text song lyric files ending in `.txt` inside:

```text
data/lyrics/
```

Then run the project again and select an option from the menu.

**Note:** Use lyrics you have permission to store and analyze.

## Command-Line Options

The project also documents these command-line options:

```bash
./main.sh --help
./main.sh --backup
./main.sh --cron
```

## Automated Backups

Example weekly cron schedule, running every Sunday at 10:00 PM:

```cron
0 22 * * 0 cd "$HOME/lyrics-word-cloud" && /bin/bash ./main.sh --backup
```

Check that the command-line backup option works in your version before enabling the schedule.

## Version Control

This project is managed with Git and hosted on GitHub.

Repository: https://github.com/pthakore12/lyrics-word-cloud

## Learning Objectives

- Practice Bash scripting and Linux commands.
- Process and analyze text files.
- Work with functions and command-line arguments.
- Generate reports and compressed backups.
- Track project changes using Git and GitHub.
