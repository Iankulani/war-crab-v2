#!/bin/bash
# ============================================================
# WAR-CRAB-V2 - Linux/macOS Setup Script
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${RED}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         🦀 WAR-CRAB-V2 - Setup Script v2.0.0                ║"
echo "║         Ultimate Cybersecurity Platform                      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            OS="debian"
        elif [ -f /etc/redhat-release ]; then
            OS="redhat"
        elif [ -f /etc/arch-release ]; then
            OS="arch"
        elif [ -f /etc/alpine-release ]; then
            OS="alpine"
        else
            OS="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    echo -e "${GREEN}✅ Detected OS: $OS${NC}"
}

# Check Python
check_python() {
    echo -e "\n${BLUE}🔍 Checking Python installation...${NC}"
    
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
        echo -e "${GREEN}✅ Python $PYTHON_VERSION found${NC}"
        
        # Check if version is >= 3.8
        if python3 -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)"; then
            echo -e "${GREEN}✅ Python version is compatible (>= 3.8)${NC}"
        else
            echo -e "${RED}❌ Python 3.8+ required. Found: $PYTHON_VERSION${NC}"
            exit 1
        fi
    else
        echo -e "${RED}❌ Python 3 not found. Please install Python 3.8+${NC}"
        exit 1
    fi
}

# Install system dependencies
install_system_deps() {
    echo -e "\n${BLUE}📦 Installing system dependencies...${NC}"
    
    case $OS in
        debian)
            sudo apt-get update
            sudo apt-get install -y \
                build-essential \
                python3-dev \
                python3-pip \
                python3-venv \
                libssl-dev \
                libffi-dev \
                libxml2-dev \
                libxslt1-dev \
                zlib1g-dev \
                libjpeg-dev \
                libpng-dev \
                libpq-dev \
                nmap \
                netcat-openbsd \
                dnsutils \
                traceroute \
                mtr-tiny \
                tcpdump \
                openssh-client \
                whois \
                file \
                binutils \
                git \
                curl \
                wget \
                htop \
                iptables \
                iproute2 \
                iputils-ping \
                net-tools \
                sqlite3 \
                redis-tools \
                postgresql-client \
                docker.io \
                docker-compose \
                hashcat \
                john \
                nikto \
                gobuster \
                ffuf \
                sqlmap \
                hydra \
                medusa \
                || true
            ;;
        redhat)
            sudo yum install -y \
                gcc \
                gcc-c++ \
                make \
                python3-devel \
                python3-pip \
                openssl-devel \
                libffi-devel \
                libxml2-devel \
                libxslt-devel \
                zlib-devel \
                libjpeg-turbo-devel \
                libpng-devel \
                postgresql-devel \
                nmap \
                nc \
                bind-utils \
                traceroute \
                tcpdump \
                openssh-clients \
                whois \
                file \
                binutils \
                git \
                curl \
                wget \
                htop \
                iptables \
                iproute \
                iputils \
                net-tools \
                sqlite \
                redis \
                postgresql \
                docker \
                docker-compose \
                hashcat \
                john \
                nikto \
                || true
            ;;
        arch)
            sudo pacman -Syu --noconfirm \
                base-devel \
                python \
                python-pip \
                openssl \
                libffi \
                libxml2 \
                libxslt \
                zlib \
                libjpeg-turbo \
                libpng \
                postgresql-libs \
                nmap \
                netcat \
                bind \
                traceroute \
                tcpdump \
                openssh \
                whois \
                file \
                binutils \
                git \
                curl \
                wget \
                htop \
                iptables \
                iproute2 \
                iputils \
                net-tools \
                sqlite \
                redis \
                postgresql \
                docker \
                docker-compose \
                hashcat \
                john \
                nikto \
                || true
            ;;
        alpine)
            sudo apk add --no-cache \
                build-base \
                python3-dev \
                py3-pip \
                openssl-dev \
                libffi-dev \
                libxml2-dev \
                libxslt-dev \
                zlib-dev \
                jpeg-dev \
                libpng-dev \
                postgresql-dev \
                nmap \
                netcat-openbsd \
                bind-tools \
                traceroute \
                tcpdump \
                openssh-client \
                whois \
                file \
                binutils \
                git \
                curl \
                wget \
                htop \
                iptables \
                iproute2 \
                iputils \
                net-tools \
                sqlite \
                redis \
                postgresql-client \
                docker \
                docker-compose \
                hashcat \
                john \
                nikto \
                || true
            ;;
        macos)
            if command -v brew &> /dev/null; then
                brew update
                brew install \
                    python3 \
                    openssl \
                    libffi \
                    libxml2 \
                    libxslt \
                    jpeg \
                    libpng \
                    postgresql \
                    nmap \
                    netcat \
                    bind \
                    traceroute \
                    tcpdump \
                    openssh \
                    whois \
                    file \
                    binutils \
                    git \
                    curl \
                    wget \
                    htop \
                    sqlite \
                    redis \
                    docker \
                    docker-compose \
                    hashcat \
                    john \
                    nikto \
                    || true
            else
                echo -e "${YELLOW}⚠️ Homebrew not found. Installing...${NC}"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                install_system_deps
            fi
            ;;
        *)
            echo -e "${YELLOW}⚠️ Unknown OS. Please install dependencies manually.${NC}"
            ;;
    esac
    
    echo -e "${GREEN}✅ System dependencies installed${NC}"
}

# Create virtual environment
create_venv() {
    echo -e "\n${BLUE}🐍 Creating Python virtual environment...${NC}"
    
    if [ -d "venv" ]; then
        echo -e "${YELLOW}⚠️ Virtual environment already exists${NC}"
        read -p "Do you want to recreate it? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf venv
        else
            return
        fi
    fi
    
    python3 -m venv venv
    source venv/bin/activate
    
    echo -e "${GREEN}✅ Virtual environment created${NC}"
}

# Install Python dependencies
install_python_deps() {
    echo -e "\n${BLUE}📦 Installing Python dependencies...${NC}"
    
    source venv/bin/activate
    pip install --upgrade pip setuptools wheel
    
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
        echo -e "${GREEN}✅ Python dependencies installed${NC}"
    else
        echo -e "${RED}❌ requirements.txt not found${NC}"
        exit 1
    fi
}

# Setup configuration
setup_config() {
    echo -e "\n${BLUE}⚙️ Setting up configuration...${NC}"
    
    mkdir -p .war_crab_v2
    mkdir -p .war_crab_v2/payloads
    mkdir -p .war_crab_v2/workspaces
    mkdir -p .war_crab_v2/scans
    mkdir -p .war_crab_v2/phishing_pages
    mkdir -p .war_crab_v2/captured_credentials
    mkdir -p .war_crab_v2/keylog_exfil
    mkdir -p .war_crab_v2/deployments
    mkdir -p .war_crab_v2/domain_hosting
    mkdir -p war_crab_v2_reports
    
    if [ ! -f ".env" ] && [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${GREEN}✅ Created .env from template${NC}"
    fi
    
    echo -e "${GREEN}✅ Configuration directories created${NC}"
}

# Verify installation
verify_installation() {
    echo -e "\n${BLUE}🔍 Verifying installation...${NC}"
    
    source venv/bin/activate
    
    python3 -c "
import sys
try:
    import requests
    import psutil
    import cryptography
    print('✅ Core dependencies verified')
except ImportError as e:
    print(f'❌ Missing dependency: {e}')
    sys.exit(1)
" || exit 1
    
    if [ -f "war_crab_v2.py" ]; then
        python3 -m py_compile war_crab_v2.py && echo -e "${GREEN}✅ Main script compiles successfully${NC}"
    fi
}

# Print summary
print_summary() {
    echo -e "\n${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              🦀 SETUP COMPLETE! 🦀                           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${CYAN}To start WAR-CRAB-V2:${NC}"
    echo -e "  ${GREEN}source venv/bin/activate${NC}"
    echo -e "  ${GREEN}python war_crab_v2.py${NC}"
    echo ""
    echo -e "${CYAN}Or use the start script:${NC}"
    echo -e "  ${GREEN}./scripts/start.sh${NC}"
    echo ""
    echo -e "${CYAN}Docker:${NC}"
    echo -e "  ${GREEN}docker-compose up -d${NC}"
    echo ""
    echo -e "${CYAN}Kubernetes:${NC}"
    echo -e "  ${GREEN}kubectl apply -f kubernetes/${NC}"
    echo ""
    echo -e "${YELLOW}⚠️ For authorized security testing only!${NC}"
    echo ""
}

# Main
main() {
    detect_os
    check_python
    install_system_deps
    create_venv
    install_python_deps
    setup_config
    verify_installation
    print_summary
}

main "$@"
