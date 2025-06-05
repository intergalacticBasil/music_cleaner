# Music Cleaner

A simple tool to clean and organize music files using beets, designed to work with label-based music organization.

## Installation

### 1. Clone or Download
Download the project files to your desired location.

### 2. Set Up Virtual Environment
Create and activate a Python virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
Install required packages:
```bash
pip install -r requirements.txt
```

### 4. Configure Beets
Create or edit your beets configuration at `~/.config/beets/config.yaml`:
```yaml
directory: ~/Music
library: ~/Music/library.db
original_date: yes

import:
  move: yes
  write: yes
  autotag: yes

paths:
  default: %if{$label,$label,_unknown}/$year %if{$albumartists,$albumartists,$albumartist} - $album/$track $title
  singleton: %if{$label,$label,_unknown}/$year $artist - $title/$track $title
  comp: %if{$label,$label,_unknown}/$year VA - $album/$track $artist - $title

va_name: "VA"

replace:
    '_␀': ', '
    '[\\/]': _
    '^\.': _
    '[\x00-\x1f]': _
    '[<>:"\?\*\|]': _
    '\.$': _
    '\s+$': ''
    '^\s+': ''
    '^-': _

plugins: embedart fetchart

musicbrainz:
    source_weight: 1.0
    extra_tags: [year, catalognum, country, label]

fetchart:
  sources: filesystem coverart

embedart:
  auto: yes

match:
  strong_rec_thresh: 0.04
  medium_rec_thresh: 0.25
```

### 5. Make Script Executable
```bash
chmod +x clean-music.sh
```

### 6. Create Directories
```bash
mkdir -p ~/Music/_unsorted
mkdir -p ~/Music
```

## Usage

1. **Add music files** to `~/Music/_unsorted/`
2. **Run the cleaner**:
   ```bash
   ./clean-music.sh
   ```
   
The script will:
- Import and tag music files using MusicBrainz
- Organize files by record label structure
- Add album artwork
- Move files from `_unsorted` to organized folders

## File Organization

Music will be organized as:
```
~/Music/
├── Label Name/
│   └── Year Artist - Album/
│       ├── 01 Track Title.mp3
│       └── 02 Another Track.mp3
└── _unknown/
    └── Year Artist - Album/
```

## Requirements

- Python 3.6+
- Internet connection (for MusicBrainz lookups)
- Music files in common formats (MP3, FLAC, etc.)
