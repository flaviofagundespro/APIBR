# 🤝 Contributing Guide - APIBR

Thank you for your interest in contributing to APIBR! This project is a professional web scraping API that serves as a free alternative to Apify.

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/flaviofagundespro/APIBR.git
cd APIBR
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Configure Environment
```bash
cp .env.example .env
# Edit .env with your local configurations
```

### 4. Start Redis (Required)
```bash
# Via Docker
docker run -d -p 6379:6379 redis:7-alpine

# Or via Docker Compose
docker-compose up redis -d
```

### 5. Run Locally
```bash
npm start
```

### 6. Test the API
```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com", "strategy": "basic", "selector": "title"}'
```

## 🐛 Reporting Bugs

Use [GitHub Issues](https://github.com/flaviofagundespro/APIBR/issues) with the following information:

### Bug Report Template:
```
**Bug Description**
Clear and concise description of the problem.

**Steps to Reproduce**
1. Go to '...'
2. Execute '...'
3. See error

**Expected Behavior**
What should happen.

**Current Behavior**
What is happening.

**Environment**
- OS: [ex: Ubuntu 20.04]
- Node.js: [ex: 18.17.0]
- Redis: [ex: 7.0]
- APIBR Version: [ex: 1.0.0]

**Error Logs**
```
Add relevant logs here
```
```

## 💡 Suggesting Improvements

Before implementing a new feature:

1. **Open an Issue** explaining your idea
2. **Discuss the proposal** with maintainers
3. **Wait for approval** before starting implementation
4. **Follow existing** code patterns

### Feature Request Template:
```
**Requested Feature**
Clear description of the feature.

**Problem it Solves**
What problem does this feature solve?

**Proposed Solution**
How do you imagine this should work?

**Alternatives Considered**
Other approaches you considered?

**Additional Context**
Screenshots, examples, etc.
```

## 📝 Pull Requests

### Process:
1. **Fork** the project
2. **Create a branch** (`git checkout -b feature/new-feature`)
3. **Make your changes** following the patterns
4. **Test locally** your changes
5. **Commit** your changes (`git commit -m 'feat: add new feature'`)
6. **Push** to the branch (`git push origin feature/new-feature`)
7. **Open a Pull Request**

### Commit Standards:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Formatting, no code change
- `refactor:` Code refactoring
- `test:` Adding or fixing tests
- `chore:` Maintenance tasks

### PR Checklist:
- [ ] Code tested locally
- [ ] Documentation updated (if needed)
- [ ] Tests passing
- [ ] Follows code standards
- [ ] Clear commit messages
- [ ] PR has clear description

## 📋 Code Standards

### JavaScript/Node.js:
- Use **ES6+** features when appropriate
- **Async/await** instead of callbacks
- **Descriptive names** for variables and functions
- **Comments** for complex logic
- **Proper error handling**

### File Structure:
```
src/
├── controllers/     # Endpoint logic
├── services/        # Business logic
├── utils/          # Utilities
├── middleware/     # Express middlewares
└── config/         # Configurations
```

### Code Example:
```javascript
// ✅ Good
async function scrapeWebsite(url, strategy) {
  try {
    const result = await scraperService.execute(url, strategy);
    return { success: true, data: result };
  } catch (error) {
    logger.error('Scraping failed:', error);
    throw new ScrapingError('Failed to scrape website', error);
  }
}

// ❌ Avoid
function scrape(u, s, cb) {
  scraperService.exec(u, s, function(err, res) {
    if (err) cb(err);
    else cb(null, res);
  });
}
```

## 🧪 Testing

### Running Tests:
```bash
# All tests
npm test

# Specific tests
npm test -- --grep "scraping"

# With coverage
npm run test:coverage
```

### Writing Tests:
- Use **Jest** for unit tests
- **Supertest** for API tests
- **Mocks** for external dependencies
- **Integration tests** when needed

### Test Example:
```javascript
describe('Scraping Service', () => {
  test('should scrape basic content', async () => {
    const result = await scrapingService.scrape({
      url: 'https://example.com',
      strategy: 'basic',
      selector: 'title'
    });
    
    expect(result.success).toBe(true);
    expect(result.data).toBeDefined();
  });
});
```

## 🛡️ Security

### Guidelines:
- **Never** commit credentials or API keys
- **Validate** all user inputs
- **Sanitize** URLs and selectors
- **Rate limiting** on public endpoints
- **HTTPS** in production

### Reporting Vulnerabilities:
For security issues, email: **[your-security-email]**

## 📚 Documentation

### Required Updates:
- **README.md**: For API or installation changes
- **API-DOCS.md**: For new endpoints or parameters
- **Code comments**: For complex logic
- **Examples**: For new features

## 🎯 Areas Needing Contribution

### 🔥 High Priority:
- [ ] Automated tests
- [ ] API documentation
- [ ] Performance optimization
- [ ] Error handling

### 🚀 Desired Features:
- [ ] Support for more scraping strategies
- [ ] Integration with more tools (Zapier, etc)
- [ ] Monitoring dashboard
- [ ] Webhook notifications
- [ ] Proxy rotation support

### 🐛 Known Bugs:
- [ ] Timeout on very slow sites
- [ ] Memory leaks in intensive scraping
- [ ] Too restrictive rate limiting

## 🏆 Recognition

All contributors will be recognized:
- **README.md**: Contributors list
- **CHANGELOG.md**: Credits per version
- **GitHub**: Contributor badge

## 📞 Support

### Communication Channels:
- **Issues**: For bugs and features
- **Discussions**: For general questions
- **Email**: [your-email] for private matters

### Response Time:
- **Critical issues**: 24-48h
- **Pull Requests**: 2-5 days
- **Feature Requests**: 1-2 weeks

---

## 🙏 Acknowledgments

Thank you for considering contributing to APIBR! Every contribution, no matter how small, makes a difference.

**Together, let's create the best free alternative to Apify!** 🚀

---

**Questions?** Open an [Issue](https://github.com/flaviofagundespro/APIBR/issues) or get in touch!
