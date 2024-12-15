# Space Extract 🎙️

Command-line tool to download Twitter/X Spaces as MP3 files with their metadata.

## 🛠️ Prerequisites

### MacOS
```bash
brew install pipenv ffmpeg jq node
```

### Linux (Ubuntu/Debian)
```bash
sudo apt-get install pipenv ffmpeg jq nodejs
```

## 📦 Installation

1. **Initial Setup**
```bash
mkdir -p ~/.local/share/space_dl
```

2. **Clone Repository**
```bash
git clone https://github.com/your-repo/space-extract.git
cd space-extract
```

3. **Install Python Dependencies**
```bash
pipenv install
```

4. **Environment Configuration**
```bash
# Add to ~/.zshrc or ~/.bashrc:
export SPACE_DL_PATH="$HOME/.local/share/space_dl"
alias space_dl='$HOME/.local/share/space_dl/extract.sh'

# Reload shell
source ~/.zshrc  # or source ~/.bashrc
```

5. **Files Installation**
```bash
cp convert-cookie.js ~/.local/share/space_dl/
cp extract.sh /usr/local/bin/
chmod +x /usr/local/bin/extract.sh
```

6. **Cookie Configuration**
- Install "EditThisCookie" browser extension
- Go to Twitter/X
- Export cookie as JSON
- Save to `~/.local/share/space_dl/cookie.json`

## 🚀 Usage

To download a Space:
```bash
space_dl "https://x.com/spaces/YOUR_ID" "output_filename"
```

### Results
- MP3: output_filename.mp3
- Metadata: output_filename.metadata.txt

## 📁 File Structure
```
~/.local/share/space_dl/
├── convert-cookie.js
├── cookie.json
└── netscape-cookies.txt

/usr/local/bin/
└── extract.sh
```

## ⚠️ Troubleshooting

### Common Error Messages
```bash
# Pipenv not installed
if ! command -v pipenv &> /dev/null; then
    echo "Pipenv is not installed. Please install it first."
    exit 1
fi

# FFmpeg not installed
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg is not installed. Please install it first."
    exit 1
fi

# cookie.json not found
if [ ! -f "$COOKIE_FILE" ]; then
    echo "Error: cookie.json file not found in $SPACE_DL_PATH"
    echo "Please create the file $COOKIE_FILE with your JSON cookie"
    exit 1
fi

# Virtual environment error
VENV_PATH=$(pipenv --venv)
if [ $? -ne 0 ]; then
    echo "Error: Virtual environment doesn't exist. Run 'pipenv install' first."
    exit 1
fi
```

### Solutions

1. **Missing Dependencies**
```bash
# MacOS
brew install pipenv ffmpeg jq node

# Linux
sudo apt-get install pipenv ffmpeg jq nodejs
```

2. **Invalid or Expired Cookie**
- Update ~/.local/share/space_dl/cookie.json
- Verify JSON format with `jq empty ~/.local/share/space_dl/cookie.json`

3. **Python Environment Issues**
```bash
cd space-extract
pipenv --rm
pipenv install
```

4. **Permission Errors**
```bash
chmod +x /usr/local/bin/extract.sh
chmod +x ~/.local/share/space_dl/convert-cookie.js
```

## 📝 Notes
- Cookie needs to be updated every 2 weeks
- Stable internet connection required
- Make sure all dependencies are properly installed
- Check file permissions if encountering access issues