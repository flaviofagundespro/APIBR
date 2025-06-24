# APIBR - AI Integration Guide

This document is specifically designed for AI assistants and automation tools (like n8n, Zapier, etc.) to understand and integrate with the APIBR web scraping API.

## 🎯 Quick Reference

### Base URL
```
http://localhost:3000/api
```

### Authentication
```bash
Header: x-api-key: your-api-key
```

## 📋 API Endpoints Summary

| Endpoint | Method | Purpose | Returns |
|----------|--------|---------|---------|
| `/api` | GET | API information | Available endpoints |
| `/api/scrape` | POST | Synchronous scraping | Scraped data immediately |
| `/api/scrape/async` | POST | Asynchronous scraping | Job ID for later retrieval |
| `/api/scrape/stats` | GET | Browser pool status | Pool statistics |
| `/api/jobs/:id` | GET | Job status | Job progress and results |
| `/health` | GET | Health check | Service status |

## 🚀 Common Use Cases

### 1. Basic Web Scraping

**Request:**
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

**Response:**
```json
{
  "success": true,
  "data": {
    "title": "Page Title",
    "links": ["https://link1.com", "https://link2.com"]
  },
  "metadata": {
    "strategy": "basic",
    "url": "https://example.com",
    "timestamp": "2024-01-01T12:00:00.000Z",
    "executionTime": 1234
  }
}
```

### 2. JavaScript Scraping

**Request:**
```json
{
  "strategy": "javascript",
  "url": "https://example.com",
  "script": "{ title: document.title, url: window.location.href }"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "title": "Page Title",
    "url": "https://example.com"
  },
  "metadata": {
    "strategy": "javascript",
    "url": "https://example.com",
    "timestamp": "2024-01-01T12:00:00.000Z",
    "executionTime": 2345
  }
}
```

### 3. Screenshot Capture

**Request:**
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

**Response:**
```json
{
  "success": true,
  "data": {
    "screenshot": "base64-encoded-image-data",
    "url": "https://example.com",
    "timestamp": "2024-01-01T12:00:00.000Z"
  },
  "metadata": {
    "strategy": "screenshot",
    "url": "https://example.com",
    "timestamp": "2024-01-01T12:00:00.000Z",
    "executionTime": 3456
  }
}
```

## 🎯 Scraping Strategies

### Strategy 1: Basic
- **Use for**: Static HTML pages
- **Key fields**: `selectors` (object with CSS selectors)
- **Best for**: Simple data extraction

### Strategy 2: JavaScript
- **Use for**: Dynamic content, complex logic
- **Key fields**: `script` (JavaScript code as string)
- **Best for**: Custom data extraction, DOM manipulation

### Strategy 3: Screenshot
- **Use for**: Visual capture
- **Key fields**: `screenshotOptions` (image settings)
- **Best for**: Visual verification, archiving

### Strategy 4: Form
- **Use for**: Interactive forms
- **Key fields**: `interactions` (array of actions), `finalSelectors` (data extraction)
- **Best for**: Login forms, search forms

## 🔧 Advanced Features

### Wait Conditions
```json
{
  "strategy": "javascript",
  "url": "https://example.com",
  "waitFor": {
    "selector": ".dynamic-content",
    "timeout": 10000
  },
  "script": "{ content: document.querySelector('.dynamic-content').textContent }"
}
```

### Multiple Elements
```json
{
  "strategy": "basic",
  "url": "https://example.com",
  "selectors": {
    "products": {
      "query": ".product",
      "multiple": true
    }
  }
}
```

### Attribute Extraction
```json
{
  "strategy": "basic",
  "url": "https://example.com",
  "selectors": {
    "images": {
      "query": "img",
      "attribute": "src",
      "multiple": true
    }
  }
}
```

## 🚨 Error Handling

### Common Error Responses

**400 Bad Request:**
```json
{
  "error": "Validation Error",
  "details": ["Invalid URL format", "Missing required field: strategy"]
}
```

**500 Internal Server Error:**
```json
{
  "error": "Internal Server Error",
  "message": "Scraping operation failed"
}
```

### Error Recovery
- **Timeout errors**: Increase `waitFor.timeout`
- **Selector not found**: Check if element exists, use `waitFor`
- **JavaScript errors**: Validate script syntax, avoid `return` statements

## 📊 Monitoring

### Health Check
```bash
GET /health
```
Returns service status and uptime.

### Browser Pool Stats
```bash
GET /api/scrape/stats
```
Returns:
```json
{
  "browserPool": {
    "total": 5,
    "available": 3,
    "busy": 2,
    "initialized": true
  },
  "timestamp": "2024-01-01T12:00:00.000Z"
}
```

## 🔄 Asynchronous Processing

### Submit Async Job
```json
{
  "strategy": "basic",
  "url": "https://example.com",
  "selectors": {
    "title": { "query": "h1" }
  },
  "webhook": {
    "url": "https://your-app.com/webhook",
    "method": "POST"
  }
}
```

### Check Job Status
```bash
GET /api/jobs/{job-id}
```

## 🎯 Real-World Examples

### E-commerce Product Scraping
```json
{
  "strategy": "basic",
  "url": "https://store.com/product/123",
  "selectors": {
    "title": { "query": ".product-title" },
    "price": { "query": ".product-price" },
    "images": { "query": ".product-image", "attribute": "src", "multiple": true },
    "description": { "query": ".product-description" }
  }
}
```

### News Article Extraction
```json
{
  "strategy": "javascript",
  "url": "https://news.com/article",
  "script": "{
    title: document.querySelector('h1')?.textContent,
    author: document.querySelector('.author')?.textContent,
    content: document.querySelector('.article-content')?.textContent,
    publishedDate: document.querySelector('.date')?.textContent
  }"
}
```

### Social Media Profile
```json
{
  "strategy": "javascript",
  "url": "https://twitter.com/username",
  "waitFor": { "selector": "[data-testid='UserName']", "timeout": 10000 },
  "script": "{
    name: document.querySelector('[data-testid=\"UserName\"]')?.textContent,
    bio: document.querySelector('[data-testid=\"UserDescription\"]')?.textContent,
    followers: document.querySelector('[data-testid=\"UserFollowers\"]')?.textContent
  }"
}
```

## ⚡ Performance Tips

1. **Use appropriate strategy**: Basic for static, JavaScript for dynamic
2. **Set wait conditions**: Prevent timeouts on slow-loading content
3. **Limit multiple elements**: Use `slice(0, 10)` for large lists
4. **Cache results**: Use Redis for repeated requests
5. **Monitor pool stats**: Check browser availability before requests

## 🔒 Security Considerations

1. **API Keys**: Always use authentication in production
2. **Rate Limiting**: Respect rate limits (100 requests/15min default)
3. **Input Validation**: Validate URLs and scripts before sending
4. **Error Handling**: Implement proper error handling in your automation

## 📞 Support

For AI assistants and automation tools:
- **Documentation**: This file and README.md
- **Examples**: See `/examples` directory
- **Testing**: Use `/health` endpoint to verify connectivity
- **Debugging**: Check `/api/scrape/stats` for system status

---

**Note for AI Assistants**: This API is designed to be AI-friendly with clear, consistent responses and comprehensive error messages. Always check the `success` field in responses and handle errors gracefully. 