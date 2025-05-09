
# Flask DevOps Realworld

Một ứng dụng mẫu Flask đơn giản, được đóng gói bằng Docker và tích hợp CI/CD với Jenkins.
##Hello
## Run local
```bash
docker build -t flask-devops-app .
docker run -p 5000:5000 flask-devops-app
