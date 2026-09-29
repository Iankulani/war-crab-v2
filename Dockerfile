# ============================================================
# WAR-CRAB-V2 - Multi-stage Dockerfile
# Base: Alpine Linux (lightweight)
# ============================================================

# ==================== BUILD STAGE ====================
FROM python:3.11-alpine AS builder

LABEL maintainer="Ian Carter Kulani <war-crab@example.com>"
LABEL description="WAR-CRAB-V2 - Ultimate Cybersecurity Platform"
LABEL version="2.0.0"

# Install build dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    linux-headers \
    libffi-dev \
    openssl-dev \
    make \
    cmake \
    git \
    rust \
    cargo \
    pkgconfig \
    libxml2-dev \
    libxslt-dev \
    jpeg-dev \
    zlib-dev \
    freetype-dev \
    lcms2-dev \
    openjpeg-dev \
    tiff-dev \
    tk-dev \
    tcl-dev \
    harfbuzz-dev \
    fribidi-dev \
    libimagequant-dev \
    libxcb-dev \
    libpng-dev

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install build tools
RUN pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel \
    build

# Copy requirements first for better caching
WORKDIR /build
COPY requirements.txt .
COPY pyproject.toml .
COPY setup.py .
COPY war_crab_v2.py .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# ==================== RUNTIME STAGE ====================
FROM python:3.11-alpine AS runtime

LABEL maintainer="Ian Carter Kulani <war-crab@example.com>"
LABEL description="WAR-CRAB-V2 - Ultimate Cybersecurity Platform"
LABEL version="2.0.0"

# Install runtime dependencies only
RUN apk add --no-cache \
    bash \
    curl \
    wget \
    nmap \
    nmap-scripts \
    netcat-openbsd \
    bind-tools \
    traceroute \
    mtr \
    tcpdump \
    openssh-client \
    openssl \
    ca-certificates \
    docker-cli \
    git \
    vim \
    nano \
    htop \
    iptables \
    iproute2 \
    iputils \
    net-tools \
    whois \
    file \
    binutils \
    libxml2 \
    libxslt \
    jpeg \
    zlib \
    freetype \
    lcms2 \
    openjpeg \
    tiff \
    tk \
    tcl \
    harfbuzz \
    fribidi \
    libimagequant \
    libxcb \
    libpng \
    sqlite \
    sqlite-dev \
    mariadb-client \
    postgresql-client \
    redis \
    && rm -rf /var/cache/apk/*

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Create non-root user
RUN addgroup -g 1000 warcrab && \
    adduser -u 1000 -G warcrab -s /bin/bash -D warcrab

# Set working directory
WORKDIR /app

# Copy application files
COPY --chown=warcrab:warcrab . .

# Create necessary directories
RUN mkdir -p \
    /app/.war_crab_v2 \
    /app/.war_crab_v2/payloads \
    /app/.war_crab_v2/workspaces \
    /app/.war_crab_v2/scans \
    /app/.war_crab_v2/phishing_pages \
    /app/.war_crab_v2/phishing_templates \
    /app/.war_crab_v2/captured_credentials \
    /app/.war_crab_v2/ssh_keys \
    /app/.war_crab_v2/traffic_logs \
    /app/.war_crab_v2/nikto_results \
    /app/.war_crab_v2/agents \
    /app/.war_crab_v2/c2_logs \
    /app/.war_crab_v2/modules \
    /app/.war_crab_v2/network_monitor \
    /app/.war_crab_v2/keylog_exfil \
    /app/.war_crab_v2/deployments \
    /app/.war_crab_v2/domain_hosting \
    /app/.war_crab_v2/docker_scans \
    /app/.war_crab_v2/cracking \
    /app/.war_crab_v2/reverse_engineering \
    /app/.war_crab_v2/shellcode \
    /app/.war_crab_v2/exploits \
    /app/.war_crab_v2/fuzzing \
    /app/war_crab_v2_reports \
    /app/temp \
    && chown -R warcrab:warcrab /app

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH=/app
ENV WARCRAB_HOME=/app
ENV WARCRAB_CONFIG=/app/.war_crab_v2

# Expose ports
# 5000 - Web Dashboard
# 8080 - Phishing Server
# 8443 - HTTPS Phishing Server
# 4444 - C2 Server
# 9001 - Agent Communication
EXPOSE 5000 8080 8443 4444 9001

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5000/api/stats', timeout=5)" || exit 1

# Switch to non-root user
USER warcrab

# Default command
ENTRYPOINT ["python", "war_crab_v2.py"]
CMD ["--help"]
