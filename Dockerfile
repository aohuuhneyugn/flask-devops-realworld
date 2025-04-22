# Sử dụng image Python chính thức
FROM python:3.10-slim

# Tạo thư mục app
WORKDIR /app

# Copy toàn bộ vào container
COPY app/ ./app

# Cài Flask
RUN pip install flask

# Chạy ứng dụng
CMD ["python", "app/app.py"]
