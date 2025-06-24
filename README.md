# APIBR - Professional Web Scraping API

[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![Redis](https://img.shields.io/badge/Redis-Required-red.svg)](https://redis.io/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A professional web scraping API built with Node.js, Puppeteer, and Redis. Features browser pool management, multiple scraping strategies, and enterprise-grade monitoring.

## 🚀 Features

- **Multiple Scraping Strategies**: Basic HTML, JavaScript execution, Screenshots, Form interactions
- **Browser Pool Management**: Efficient resource management with configurable pool size
- **Redis Integration**: Caching and job queue management
- **Rate Limiting**: Built-in protection against abuse
- **Monitoring**: Prometheus metrics and comprehensive logging
- **Docker Support**: Easy deployment with Docker Compose
- **API Documentation**: Swagger/OpenAPI documentation
- **Authentication**: Optional API key authentication

## 📋 Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [API Reference](#api-reference)
- [Scraping Strategies](#scraping-strategies)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Examples](#examples)
- [Contributing](#contributing)

## 🛠️ Installation

### Prerequisites

- Node.js 18+
- Redis 6+
- Docker (optional)

### Local Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/apibr.git
cd apibr

# Install dependencies
npm install

# Start Redis (if not running)
docker run -d -p 6379:6379 redis

# Start the application
npm start
```

### Docker Installation

```bash
# Clone and start with Docker Compose
git clone https://github.com/yourusername/apibr.git
cd apibr
docker-compose up -d
```

## 🚀 Quick Start

### 1. Basic Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "basic",
    "url": "https://example.com",
    "selectors": {
      "title": {
        "query": "h1"
      },
      "links": {
        "query": "a",
        "attribute": "href",
        "multiple": true
      }
    }
  }'
```

### 2. JavaScript Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://example.com",
    "script": "{ title: document.title, url: window.location.href }"
  }'
```

### 3. Screenshot Capture

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "screenshot",
    "url": "https://example.com",
    "screenshotOptions": {
      "fullPage": true,
      "type": "png"
    }
  }'
```

## 📖 API Reference

### Base URL
```
http://localhost:3000/api
```

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api` | API information and available endpoints |
| `POST` | `/api/scrape` | Synchronous web scraping |
| `POST` | `/api/scrape/async` | Asynchronous web scraping (job queue) |
| `GET` | `/api/scrape/stats` | Browser pool statistics |
| `GET` | `/api/jobs/:id` | Get job status |
| `GET` | `/api/metrics` | Prometheus metrics |
| `GET` | `/api/docs` | Swagger documentation |
| `GET` | `/health` | Health check |

### Authentication

Optional API key authentication via header:
```bash
curl -H "x-api-key: your-api-key" ...
```

## 🎯 Scraping Strategies

### 1. Basic Strategy

Extract data using CSS selectors.

```json
{
  "strategy": "basic",
  "url": "https://example.com",
  "selectors": {
    "title": {
      "query": "h1"
    },
    "links": {
      "query": "a",
      "attribute": "href",
      "multiple": true
    }
  }
}
```

### 2. JavaScript Strategy

Execute custom JavaScript code.

```json
{
  "strategy": "javascript",
  "url": "https://example.com",
  "script": "{ title: document.title, url: window.location.href }"
}
```

### 3. Screenshot Strategy

Capture screenshots of web pages.

```json
{
  "strategy": "screenshot",
  "url": "https://example.com",
  "screenshotOptions": {
    "fullPage": true,
    "type": "png"
  }
}
```

### 4. Form Interaction Strategy

Interact with forms and extract data.

```json
{
  "strategy": "form",
  "url": "https://example.com",
  "interactions": [
    {
      "type": "type",
      "selector": "#search",
      "value": "search term"
    },
    {
      "type": "click",
      "selector": "#submit"
    }
  ],
  "finalSelectors": {
    "results": {
      "query": ".result",
      "multiple": true
    }
  }
}
```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# Redis Configuration
REDIS_URL=redis://localhost:6379
CACHE_TTL=3600

# Browser Pool Configuration
BROWSER_POOL_SIZE=5
BROWSER_HEADLESS=true
BROWSER_TIMEOUT=30000

# Rate Limiting
RATE_LIMIT_WINDOW=900000
RATE_LIMIT_MAX=100

# Authentication
API_KEYS=key1,key2,key3

# Logging
LOG_LEVEL=info
LOG_FORMAT=json
```

### Docker Configuration

```yaml
# docker-compose.yml
version: '3.8'
services:
  apibr:
    build: .
    ports:
      - "3000:3000"
    environment:
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis
      - prometheus

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml
```

## 🚀 Deployment

### Production Deployment

1. **Environment Setup**
```bash
# Set production environment
export NODE_ENV=production
export REDIS_URL=redis://your-redis-server:6379
export API_KEYS=your-secure-api-key
```

2. **Docker Deployment**
```bash
docker-compose -f docker-compose.prod.yml up -d
```

3. **PM2 Deployment**
```bash
npm install -g pm2
pm2 start ecosystem.config.js
```

### Monitoring

- **Health Check**: `GET /health`
- **Metrics**: `GET /api/metrics`
- **Pool Stats**: `GET /api/scrape/stats`

## 📝 Examples

### YouTube Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://www.youtube.com/@channel",
    "waitFor": {
      "selector": "#content",
      "timeout": 10000
    },
    "script": "{
      channelName: document.querySelector(\"#channel-name\")?.textContent,
      subscribers: document.querySelector(\"#subscriber-count\")?.textContent,
      videos: Array.from(document.querySelectorAll(\"#video-title\")).slice(0, 10).map(v => ({
        title: v.textContent,
        url: v.href
      }))
    }"
  }'
```

### E-commerce Product Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "basic",
    "url": "https://example-store.com/product",
    "selectors": {
      "title": {
        "query": ".product-title"
      },
      "price": {
        "query": ".product-price"
      },
      "images": {
        "query": ".product-image",
        "attribute": "src",
        "multiple": true
      }
    }
  }'
```

### News Article Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://news-site.com/article",
    "script": "{
      title: document.querySelector(\"h1\")?.textContent,
      author: document.querySelector(\".author\")?.textContent,
      content: document.querySelector(\".article-content\")?.textContent,
      publishedDate: document.querySelector(\".date\")?.textContent
    }"
  }'
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

```bash
# Install dependencies
npm install

# Run tests
npm test

# Run linting
npm run lint

# Start development server
npm run dev
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Puppeteer](https://pptr.dev/) - Browser automation
- [Express](https://expressjs.com/) - Web framework
- [Redis](https://redis.io/) - Caching and job queue
- [Prometheus](https://prometheus.io/) - Monitoring

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/apibr/issues)
- **Documentation**: [Wiki](https://github.com/yourusername/apibr/wiki)
- **Email**: your-email@example.com

---

**Made with ❤️ by [Your Name]**

