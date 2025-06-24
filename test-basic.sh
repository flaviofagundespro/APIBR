#!/bin/bash

echo "🧪 Testando APIBR API..."

# Start server in background
echo "🚀 Iniciando servidor..."
npm start > server.log 2>&1 &
SERVER_PID=$!

# Wait for server to start
echo "⏳ Aguardando servidor inicializar..."
sleep 8

# Test health endpoint
echo "🏥 Testando health check..."
HEALTH_RESPONSE=$(curl -s http://localhost:3000/health)
if echo "$HEALTH_RESPONSE" | grep -q '"status":"ok"'; then
    echo "✅ Health check passou"
else
    echo "❌ Health check falhou"
    echo "Response: $HEALTH_RESPONSE"
fi

# Test API info
echo "📋 Testando API info..."
API_INFO=$(curl -s http://localhost:3000/api)
if echo "$API_INFO" | grep -q '"name"'; then
    echo "✅ API info passou"
else
    echo "❌ API info falhou"
fi

# Test metrics
echo "📊 Testando métricas..."
METRICS=$(curl -s http://localhost:3000/api/metrics)
if echo "$METRICS" | grep -q 'apibr_'; then
    echo "✅ Métricas passaram"
else
    echo "❌ Métricas falharam"
fi

# Test docs
echo "📚 Testando documentação..."
DOCS=$(curl -s http://localhost:3000/api/docs/spec)
if echo "$DOCS" | grep -q '"openapi"'; then
    echo "✅ Documentação passou"
else
    echo "❌ Documentação falhou"
fi

# Cleanup
echo "🧹 Limpando..."
kill $SERVER_PID 2>/dev/null
wait $SERVER_PID 2>/dev/null

echo "🎉 Testes básicos concluídos!"

