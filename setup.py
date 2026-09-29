#!/usr/bin/env python3
"""
WAR-CRAB-V2 Setup Script
"""

from setuptools import setup, find_packages
from pathlib import Path

# Read README
this_directory = Path(__file__).parent
long_description = ""
if (this_directory / "README.md").exists():
    long_description = (this_directory / "README.md").read_text(encoding="utf-8")

# Read requirements
requirements = []
if (this_directory / "requirements.txt").exists():
    with open(this_directory / "requirements.txt") as f:
        requirements = [
            line.strip()
            for line in f
            if line.strip() and not line.startswith("#")
        ]

setup(
    name="war-crab-v2",
    version="2.0.0",
    author="Ian Carter Kulani",
    author_email="war-crab@example.com",
    description="Ultimate Cybersecurity Command & Control Platform",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/iancarter/war-crab-v2",
    project_urls={
        "Bug Tracker": "https://github.com/iancarter/war-crab-v2/issues",
        "Documentation": "https://war-crab-v2.readthedocs.io",
        "Source Code": "https://github.com/iancarter/war-crab-v2",
    },
    packages=find_packages(exclude=["tests*", "docs*"]),
    py_modules=["war_crab_v2"],
    python_requires=">=3.8",
    install_requires=requirements,
    extras_require={
        "dev": [
            "pytest>=7.4.0",
            "pytest-asyncio>=0.21.0",
            "pytest-cov>=4.1.0",
            "black>=23.7.0",
            "flake8>=6.1.0",
            "mypy>=1.5.0",
            "isort>=5.12.0",
            "pylint>=2.17.0",
        ],
        "docs": [
            "sphinx>=7.1.0",
            "sphinx-rtd-theme>=1.3.0",
            "mkdocs>=1.5.0",
            "mkdocs-material>=9.2.0",
        ],
        "bots": [
            "discord.py>=2.3.0",
            "python-telegram-bot>=20.0",
            "telethon>=1.29.0",
            "slack-sdk>=3.23.0",
        ],
        "web": [
            "Flask>=2.3.0",
            "Flask-SocketIO>=5.3.0",
            "Flask-CORS>=4.0.0",
        ],
        "security": [
            "scapy>=2.5.0",
            "cryptography>=41.0.0",
            "paramiko>=3.3.0",
            "pynput>=1.7.6",
        ],
        "cracking": [
            "passlib>=1.7.4",
            "bcrypt>=4.0.0",
            "argon2-cffi>=23.1.0",
        ],
        "reverse": [
            "pefile>=2023.2.7",
            "pyelftools>=0.29",
            "capstone>=5.0.0",
        ],
    },
    entry_points={
        "console_scripts": [
            "war-crab=war_crab_v2:main",
            "warcrab=war_crab_v2:main",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Environment :: Console",
        "Intended Audience :: Information Technology",
        "Intended Audience :: System Administrators",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Topic :: Security",
        "Topic :: System :: Networking :: Monitoring",
        "Topic :: System :: Systems Administration",
        "Topic :: Utilities",
    ],
    keywords=[
        "security", "cybersecurity", "penetration-testing",
        "network-monitoring", "keylogger", "phishing",
        "command-and-control", "c2", "botnet", "red-team",
    ],
    include_package_data=True,
    zip_safe=False,
)
