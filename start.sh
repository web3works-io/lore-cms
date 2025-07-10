#!/bin/bash

# Lore.meme Directus with Cloudflare R2 Storage
# This script starts the Directus backend with R2 configuration

echo "🚀 Starting Lore.meme Directus Backend with Cloudflare R2..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "📝 Please copy .env.example to .env and configure your settings:"
    echo "   cp .env.example .env"
    echo "   nano .env"
    exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Build and start the containers
echo "🔨 Building Docker containers..."
docker-compose build

echo "🚀 Starting services..."
docker-compose up -d

# Wait a moment for services to start
sleep 5

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Services started successfully!"
    echo ""
    echo "🌐 Directus Admin: http://localhost:8055"
    echo "🗄️  PgAdmin: http://localhost:5050"
    echo ""
    echo "📊 Default Admin Credentials:"
    echo "   Email: admin@example.com"
    echo "   Password: d1r3ctu5"
    echo ""
    echo "🔧 To view logs: docker-compose logs -f"
    echo "🛑 To stop: docker-compose down"
else
    echo "❌ Failed to start services. Check logs with: docker-compose logs"
    exit 1
fi