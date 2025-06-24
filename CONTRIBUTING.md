# 🤝 Guia de Contribuição - APIBR

Obrigado pelo interesse em contribuir com a APIBR! Este projeto é uma API de scraping profissional que serve como alternativa gratuita ao Apify.

## 🚀 Como Começar

### 1. Clone o Repositório
```bash
git clone https://github.com/flaviofagundespro/APIBR.git
cd APIBR
```

### 2. Instale as Dependências
```bash
npm install
```

### 3. Configure o Ambiente
```bash
cp .env.example .env
# Edite o .env com suas configurações locais
```

### 4. Inicie o Redis (Obrigatório)
```bash
# Via Docker
docker run -d -p 6379:6379 redis:7-alpine

# Ou via Docker Compose
docker-compose up redis -d
```

### 5. Execute Localmente
```bash
npm start
```

### 6. Teste a API
```bash
curl -X POST http://localhost:3000/api/scrape \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com", "strategy": "basic", "selector": "title"}'
```

## 🐛 Reportar Bugs

Use as [Issues do GitHub](https://github.com/flaviofagundespro/APIBR/issues) com as seguintes informações:

### Template para Bug Report:
```
**Descrição do Bug**
Descrição clara e concisa do problema.

**Passos para Reproduzir**
1. Vá para '...'
2. Execute '...'
3. Veja o erro

**Comportamento Esperado**
O que deveria acontecer.

**Comportamento Atual**
O que está acontecendo.

**Ambiente**
- OS: [ex: Ubuntu 20.04]
- Node.js: [ex: 18.17.0]
- Redis: [ex: 7.0]
- Versão da APIBR: [ex: 1.0.0]

**Logs de Erro**
```
Adicione logs relevantes aqui
```
```

## 💡 Sugerir Melhorias

Antes de implementar uma nova funcionalidade:

1. **Abra uma Issue** explicando sua ideia
2. **Discuta a proposta** com os mantenedores
3. **Aguarde aprovação** antes de começar a implementar
4. **Siga os padrões** de código existentes

### Template para Feature Request:
```
**Funcionalidade Solicitada**
Descrição clara da funcionalidade.

**Problema que Resolve**
Que problema esta funcionalidade resolve?

**Solução Proposta**
Como você imagina que isso deveria funcionar?

**Alternativas Consideradas**
Outras abordagens que você considerou?

**Contexto Adicional**
Screenshots, exemplos, etc.
```

## 📝 Pull Requests

### Processo:
1. **Fork** o projeto
2. **Crie uma branch** (`git checkout -b feature/nova-funcionalidade`)
3. **Faça suas alterações** seguindo os padrões
4. **Teste localmente** suas mudanças
5. **Commit** suas mudanças (`git commit -m 'feat: adiciona nova funcionalidade'`)
6. **Push** para a branch (`git push origin feature/nova-funcionalidade`)
7. **Abra um Pull Request**

### Padrões de Commit:
- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Mudanças na documentação
- `style:` Formatação, sem mudança de código
- `refactor:` Refatoração de código
- `test:` Adição ou correção de testes
- `chore:` Tarefas de manutenção

### Checklist do PR:
- [ ] Código testado localmente
- [ ] Documentação atualizada (se necessário)
- [ ] Testes passando
- [ ] Segue padrões de código
- [ ] Commit messages claras
- [ ] PR tem descrição clara

## 📋 Padrões de Código

### JavaScript/Node.js:
- Use **ES6+** features quando apropriado
- **Async/await** ao invés de callbacks
- **Nomes descritivos** para variáveis e funções
- **Comentários** para lógica complexa
- **Error handling** adequado

### Estrutura de Arquivos:
```
src/
├── controllers/     # Lógica dos endpoints
├── services/        # Lógica de negócio
├── utils/          # Utilitários
├── middleware/     # Middlewares Express
└── config/         # Configurações
```

### Exemplo de Código:
```javascript
// ✅ Bom
async function scrapeWebsite(url, strategy) {
  try {
    const result = await scraperService.execute(url, strategy);
    return { success: true, data: result };
  } catch (error) {
    logger.error('Scraping failed:', error);
    throw new ScrapingError('Failed to scrape website', error);
  }
}

// ❌ Evitar
function scrape(u, s, cb) {
  scraperService.exec(u, s, function(err, res) {
    if (err) cb(err);
    else cb(null, res);
  });
}
```

## 🧪 Testes

### Executar Testes:
```bash
# Todos os testes
npm test

# Testes específicos
npm test -- --grep "scraping"

# Com coverage
npm run test:coverage
```

### Escrever Testes:
- Use **Jest** para testes unitários
- **Supertest** para testes de API
- **Mocks** para dependências externas
- **Testes de integração** quando necessário

### Exemplo de Teste:
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

## 🛡️ Segurança

### Diretrizes:
- **Nunca** commite credenciais ou chaves de API
- **Valide** todas as entradas do usuário
- **Sanitize** URLs e seletores
- **Rate limiting** em endpoints públicos
- **HTTPS** em produção

### Reportar Vulnerabilidades:
Para questões de segurança, envie email para: **[seu-email-seguranca]**

## 📚 Documentação

### Atualizações Necessárias:
- **README.md**: Para mudanças na API ou instalação
- **API-DOCS.md**: Para novos endpoints ou parâmetros
- **Comentários no código**: Para lógica complexa
- **Exemplos**: Para novas funcionalidades

## 🎯 Áreas que Precisam de Contribuição

### 🔥 Alta Prioridade:
- [ ] Testes automatizados
- [ ] Documentação de APIs
- [ ] Otimização de performance
- [ ] Tratamento de erros

### 🚀 Funcionalidades Desejadas:
- [ ] Suporte a mais estratégias de scraping
- [ ] Integração com mais ferramentas (Zapier, etc)
- [ ] Dashboard de monitoramento
- [ ] Webhook notifications
- [ ] Suporte a proxy rotation

### 🐛 Bugs Conhecidos:
- [ ] Timeout em sites muito lentos
- [ ] Memory leaks em scraping intensivo
- [ ] Rate limiting muito restritivo

## 🏆 Reconhecimento

Todos os contribuidores serão reconhecidos:
- **README.md**: Lista de contribuidores
- **CHANGELOG.md**: Créditos por versão
- **GitHub**: Contributor badge

## 📞 Suporte

### Canais de Comunicação:
- **Issues**: Para bugs e features
- **Discussions**: Para dúvidas gerais
- **Email**: [seu-email] para questões privadas

### Tempo de Resposta:
- **Issues críticas**: 24-48h
- **Pull Requests**: 2-5 dias
- **Feature Requests**: 1-2 semanas

---

## 🙏 Agradecimentos

Obrigado por considerar contribuir com a APIBR! Cada contribuição, por menor que seja, faz diferença.

**Juntos, vamos criar a melhor alternativa gratuita ao Apify!** 🚀

---

**Dúvidas?** Abra uma [Issue](https://github.com/flaviofagundespro/APIBR/issues) ou entre em contato!
