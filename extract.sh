#!/usr/bin/env sh
#@author: GaloisField
#@description: Extract X Space from url -> https://x.com/spaces/ID
#@requirements: Extract cookies from webbrowser (You can use EditThisCookie extension)
#@args: ./extract.sh URL Name_output



echo "🔍 Starting extraction process..."
echo "📂 SPACE_DL_PATH = $SPACE_DL_PATH"

# Check required tools
echo "🔧 Checking required tools..."
if ! command -v pipenv &> /dev/null; then
    echo "❌ Error: Pipenv is not installed. Please install it first."
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "❌ Error: FFmpeg is not installed. Please install it first."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "❌ Error: jq is not installed. Please install it first."
    exit 1
fi

# Check required files
COOKIE_FILE="$SPACE_DL_PATH/cookie.json"
COOKIES_TXT="$SPACE_DL_PATH/netscape-cookies.txt"

echo "🔍 Checking required files..."
echo "   Cookie JSON: $COOKIE_FILE"
echo "   Cookie TXT: $COOKIES_TXT"

if [ ! -f "$COOKIE_FILE" ]; then
    echo "❌ Error: cookie.json file not found in $SPACE_DL_PATH"
    echo "   Please create $COOKIE_FILE with your JSON cookie"
    exit 1
fi

if [ ! -f "$SPACE_DL_PATH/convert-cookie.js" ]; then
    echo "❌ Error: convert-cookie.js not found in $SPACE_DL_PATH"
    exit 1
fi

# Verify JSON format
echo "🔍 Verifying cookie JSON format..."
if ! jq empty "$COOKIE_FILE" 2>/dev/null; then
    echo "❌ Error: cookie.json is not a valid JSON file"
    exit 1
fi

URL=$1
OUTPUT=$2

echo "🌐 Space URL: $URL"
echo "📝 Output name: $OUTPUT"

# Get virtualenv path dynamically
echo "🔍 Looking for virtual environment..."
VENV_PATH=$(pipenv --venv)
if [ $? -ne 0 ]; then
    echo "❌ Error: Virtual environment not found. Run 'pipenv install' first."
    exit 1
fi

echo "✅ Virtual environment found: $VENV_PATH"

# Source the virtual environment
echo "🔧 Activating virtual environment..."
. "$VENV_PATH/bin/activate"

# Convert cookie JSON to netscape format
echo "🔄 Converting cookie to Netscape format..."
node $SPACE_DL_PATH/convert-cookie.js > "$COOKIES_TXT" || {
    echo "❌ Error during cookie conversion"
    exit 1
}

# Download the space
echo "⬇️ Downloading Space..."
twspace_dl -c "$COOKIES_TXT" -i $URL -o $OUTPUT || {
    echo "❌ Error while downloading space"
    exit 1
}

# Extract metadata to a separate file
echo "📄 Extracting metadata..."
ffmpeg -i $(pwd)/$OUTPUT.m4a -f ffmetadata $(pwd)/$OUTPUT.metadata.txt 2>/dev/null

# Convert to MP3
echo "🎵 Converting to MP3..."
ffmpeg -i $(pwd)/$OUTPUT.m4a -codec:a libmp3lame -qscale:a 2 $(pwd)/$OUTPUT.mp3 || {
    echo "❌ Error during MP3 conversion"
    exit 1
}

# Clean up
echo "🧹 Cleaning up..."
rm -f $(pwd)/$OUTPUT.m4a

echo "✨ Extraction completed successfully!"
echo "📝 Metadata has been saved to $OUTPUT.metadata.txt"
