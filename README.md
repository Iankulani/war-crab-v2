# war-crab-v2
<div align="center">

<img width="360" height="360" alt="warcrab" src="https://github.com/user-attachments/assets/e85c75da-afda-47e2-9ef3-5780dbe91279" />

[![GitHub stars](https://img.shields.io/github/stars/Iankulani/war-crab-v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/war-crab-v2/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Iankulani/war-crab-v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/war-crab-v2/network)
[![GitHub watchers](https://img.shields.io/github/watchers/Iankulani/war-crab-v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/war-crab-v2/watchers)
[![GitHub contributors](https://img.shields.io/github/contributors/Iankulani/war-crab-v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/war-crab-v2/graphs/contributors)
[![GitHub last commit](https://img.shields.io/github/last-commit/Iankulani/war-crab-v2?style=for-the-badge&logo=git)](https://github.com/Iankulani/war-crab-v2/commits/main)
[![License](https://img.shields.io/github/license/Iankulani/war-crab-v2?style=for-the-badge)](https://github.com/Iankulani/war-crab-v2/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20macOS-blue?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/Iankulani/war-crab-v2)
[![Python](https://img.shields.io/badge/python-3.x-blue?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)

</div>

War Crab is an advanced cybersecurity software solution developed to support security professionals, system administrators, penetration testers, and cybersecurity researchers in identifying vulnerabilities, testing network security, and strengthening digital infrastructure. Designed to support modern cybersecurity operations, War Crab provides a centralized platform for executing security commands, conducting authorized assessments, and coordinating cybersecurity activities through multiple communication channels.

One of War Crab's key features is its multi-platform command interface. The software enables authorized users to interact with the system and execute supported cybersecurity commands through Discord, Telegram, Slack, Google Chat, and a web application. This flexibility allows users to access security tools, manage testing activities, and receive results through their preferred communication platform. By integrating these channels, War Crab aims to simplify cybersecurity workflows and make security operations more accessible.

War Crab is designed to support a variety of cybersecurity testing activities, including penetration testing, network diagnostics, vulnerability assessments, and simulated cyber drills. Security professionals can use its capabilities to evaluate the security posture of authorized systems, identify potential weaknesses, and investigate issues affecting networks and applications. Its testing functionality can help organizations understand their exposure to cyber threats and develop appropriate defensive strategies.

The software can incorporate network diagnostic features such as connectivity checks, ping tests, traceroute analysis, service discovery, and authorized port scanning. These capabilities help users investigate network availability, understand communication paths, and identify potentially exposed services. Additional integrations with established open-source security utilities can extend War Crab's capabilities, allowing security teams to organize different testing operations through a unified interface.

Another important component of War Crab is its potential role in Security Operations Center (SOC) activities. The platform can be designed to support security monitoring, event reporting, incident investigation, and operational coordination. By collecting relevant information and presenting results in an organized format, War Crab can help security teams investigate suspicious activity and respond to potential security incidents more efficiently.

War Crab can also support controlled cybersecurity drills and penetration-testing exercises. These activities allow organizations to simulate realistic security scenarios, evaluate defensive controls, and assess incident-response procedures. Where appropriate, testing modules can include phishing-awareness simulations, security configuration assessments, and controlled demonstrations of common attack techniques. Such exercises should be conducted only within authorized environments and with suitable safeguards.

To improve usability, War Crab can incorporate automated task execution, configurable command modules, structured reports, logging, and customizable workflows. Role-based access controls and authentication can help ensure that only approved users can execute sensitive operations. Audit logs can record command activity, while configurable permissions can restrict testing to designated systems and environments.

The web application can serve as a central dashboard for managing security tasks, viewing results, configuring integrations, and reviewing historical activity. Meanwhile, Discord, Telegram, Slack, and Google Chat integrations can provide convenient interfaces for submitting approved commands and receiving notifications.

War Crab represents a flexible approach to modern cybersecurity operations, combining multi-platform command execution, network diagnostics, authorized penetration testing, cybersecurity drills, and defensive analysis. Developed with security, usability, and responsible testing in mind, War Crab can help cybersecurity professionals streamline their workflows, evaluate digital defenses, and build stronger protection against evolving cyber threats.
Docker Deployment


# Build and run with Docker Compose
```bash
docker-compose up -d
```

# View logs
```bash
docker-compose logs -f war-crab
```

# Stop
```bash
docker-compose down
Kubernetes Deployment
```


# Apply all manifests

```bash
kubectl apply -f kubernetes/
```

# Check status
```bash
kubectl get pods -n war-crab
kubectl get svc -n war-crab
kubectl get ingress -n war-crab
```

# View logs
```bash
kubectl logs -f deployment/war-crab-v2 -n war-crab
```
# Windows Setup

```bash
REM Run setup
scripts\setup.bat
```

# REM Start
```bash
scripts\start.bat
```
# powershell
```bash
.\scripts\setup.ps1
```
# Start
```bash
.\scripts\start.ps1
```

# Documentation

# Star History
