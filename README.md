# war-crab-v2
<div align="center">



<img width="360" height="360" alt="warcrab" src="https://github.com/user-attachments/assets/e85c75da-afda-47e2-9ef3-5780dbe91279" />

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

REM Run setup
scripts\setup.bat

REM Start
scripts\start.bat
powershell
# PowerShell setup
.\scripts\setup.ps1

# Start
```bash
.\scripts\start.ps1
```
