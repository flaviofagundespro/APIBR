# 🚀 APIBR - Professional Web Scraping API

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![Express.js](https://img.shields.io/badge/Express.js-404D59?style=flat&logo=express)](https://expressjs.com/)
[![Redis](https://img.shields.io/badge/Redis-Required-red.svg)](https://redis.io/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://docker.com/)
[![GitHub stars](https://img.shields.io/github/stars/flaviofagundespro/APIBR.svg)](https://github.com/flaviofagundespro/APIBR/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/flaviofagundespro/APIBR.svg)](https://github.com/flaviofagundespro/APIBR/network)

> **A powerful, free alternative to Apify for web scraping automation**

A professional web scraping API built with Node.js, Puppeteer, and Redis. Features browser pool management, multiple scraping strategies, and enterprise-level monitoring.

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
git clone https://github.com/flaviofagundespro/APIBR.git
cd APIBR

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
git clone https://github.com/flaviofagundespro/APIBR.git
cd APIBR
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
  "formData": {
    "username": "test@example.com",
    "password": "password123"
  },
  "selectors": {
    "result": {
      "query": ".result-message"
    }
  }
}
```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file based on `.env.example`:

```bash
# Server Configuration
PORT=3000
NODE_ENV=development

# Redis Configuration
REDIS_URL=redis://localhost:6379

# Browser Pool Configuration
BROWSER_POOL_SIZE=5
BROWSER_TIMEOUT=30000

# Rate Limiting
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX_REQUESTS=100

# API Authentication (optional)
API_KEY=your-secret-api-key
```

### Docker Configuration

The `docker-compose.yml` includes:
- **APIBR**: Main application
- **Redis**: Cache and job queue
- **Prometheus**: Metrics collection
- **Grafana**: Metrics visualization

## 🚀 Deployment

### Production Deployment

```bash
# Build and start production services
docker-compose -f docker-compose.prod.yml up -d

# Or deploy to cloud platforms
npm run deploy:heroku
npm run deploy:aws
```

### Environment-Specific Configurations

- **Development**: Local Redis, debug logging
- **Staging**: Cloud Redis, moderate logging
- **Production**: High-availability Redis, minimal logging

## 📚 Examples

### E-commerce Scraping

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "basic",
    "url": "https://example-store.com/products",
    "selectors": {
      "products": {
        "query": ".product-item",
        "multiple": true,
        "extract": {
          "name": ".product-name",
          "price": ".product-price",
          "image": {
            "query": "img",
            "attribute": "src"
          }
        }
      }
    }
  }'
```

### Social Media Monitoring

```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://twitter.com/username",
    "script": "{
      const tweets = Array.from(document.querySelectorAll(\".tweet\")).map(tweet => ({
        text: tweet.querySelector(\".tweet-text\")?.textContent,
        timestamp: tweet.querySelector(\".timestamp\")?.textContent,
        likes: tweet.querySelector(\".like-count\")?.textContent
      }));
      return { tweets, count: tweets.length };
    }"
  }'
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Puppeteer**: For browser automation
- **Express.js**: For the web framework
- **Redis**: For caching and job queues
- **Prometheus**: For metrics collection

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/flaviofagundespro/APIBR/issues)
- **Documentation**: [API Docs](http://localhost:3000/api/docs)
- **Email**: [Your Email]

---

**Made with ❤️ for the open source community**

