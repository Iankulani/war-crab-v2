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

War crab

Docker Deployment
bash
# Build and run with Docker Compose
docker-compose up -d

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
