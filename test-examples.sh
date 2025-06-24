#!/bin/bash

# Exemplos corrigidos para testar a APIBR
# Execute: chmod +x test-examples.sh && ./test-examples.sh

API_URL="http://localhost:3000/api"

echo "🧪 Testando APIBR - Exemplos Corrigidos"
echo "========================================"

# Teste 1: Informações da API
echo -e "\n1️⃣ Testando endpoint de informações da API..."
curl -s "$API_URL" | jq '.'

# Teste 2: Scraping básico com seletores simples
echo -e "\n2️⃣ Testando scraping básico (example.com)..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "basic",
    "url": "https://example.com",
    "selectors": {
      "title": {
        "query": "h1"
      },
      "paragraph": {
        "query": "p"
      }
    }
  }' | jq '.'

# Teste 3: JavaScript strategy corrigido
echo -e "\n3️⃣ Testando JavaScript strategy (Google)..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://www.google.com",
    "script": "document.title + \" - \" + window.location.href"
  }' | jq '.'

# Teste 4: JavaScript com objeto
echo -e "\n4️⃣ Testando JavaScript com objeto retornado..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "javascript",
    "url": "https://httpbin.org/html",
    "script": "({ title: document.title, url: window.location.href, hasBody: !!document.body })"
  }' | jq '.'

# Teste 5: Screenshot PNG (corrigido)
echo -e "\n5️⃣ Testando screenshot PNG..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "screenshot",
    "url": "https://example.com",
    "screenshotOptions": {
      "fullPage": false,
      "type": "png"
    }
  }' | jq '.data.screenshot | length'

# Teste 6: Screenshot JPEG com quality
echo -e "\n6️⃣ Testando screenshot JPEG com quality..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "screenshot",
    "url": "https://example.com",
    "screenshotOptions": {
      "fullPage": false,
      "type": "jpeg",
      "quality": 80
    }
  }' | jq '.data.screenshot | length'

# Teste 7: Scraping com wait
echo -e "\n7️⃣ Testando scraping com wait..."
curl -s -X POST "$API_URL/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "strategy": "basic",
    "url": "https://quotes.toscrape.com",
    "waitFor": {
      "selector": ".quote",
      "timeout": 5000
    },
    "selectors": {
      "quotes": {
        "query": ".quote .text",
        "multiple": true
      },
      "authors": {
        "query": ".quote .author",
        "multiple": true
      }
    }
  }' | jq '.'

# Teste 8: Estatísticas do pool
echo -e "\n8️⃣ Testando estatísticas do pool..."
curl -s "$API_URL/scrape/stats" | jq '.'

echo -e "\n✅ Testes concluídos!" 