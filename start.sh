#!/bin/bash
# ============================================================
# WAR-CRAB-V2 - Start Script
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${RED}"
echo "🦀 Starting WAR-CRAB-V2..."
echo -e "${NC}"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}⚠️ Virtual environment not found. Run setup.sh first.${NC}"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}⚠️ Not running as root. Some features may be limited.${NC}"
    echo -e "${YELLOW}   Use 'sudo ./scripts/start.sh' for full functionality.${NC}"
fi

# Check for required environment variables
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs) 2>/dev/null || true
fi

# Start the application
python3 war_crab_v2.py "$@"
