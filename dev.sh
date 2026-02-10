#!/bin/bash
# Navigate to the public directory
cd "$(dirname "$0")/public" || exit

# Start the Python HTTP server
echo "Starting local development server..."
echo "Open http://localhost:8000 in your browser"
python3 -m http.server
