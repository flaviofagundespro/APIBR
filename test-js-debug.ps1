# Teste JavaScript com debug
$API_URL = "http://172.19.144.1:3000/api"

Write-Host "🧪 Teste JavaScript Strategy com Debug" -ForegroundColor Green

# Teste 1: JavaScript simples
$body1 = @{
    strategy = "javascript"
    url = "https://httpbin.org/html"
    script = "document.title"
} | ConvertTo-Json -Depth 3

Write-Host "`n1️⃣ Teste 1: String simples" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body1 -ContentType "application/json"
    Write-Host "Resultado:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 2: JavaScript com objeto
$body2 = @{
    strategy = "javascript"
    url = "https://httpbin.org/html"
    script = "({ title: document.title, url: window.location.href })"
} | ConvertTo-Json -Depth 3

Write-Host "`n2️⃣ Teste 2: Objeto" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body2 -ContentType "application/json"
    Write-Host "Resultado:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 3: JavaScript com função
$body3 = @{
    strategy = "javascript"
    url = "https://httpbin.org/html"
    script = "function() { return { title: document.title, url: window.location.href }; }"
} | ConvertTo-Json -Depth 3

Write-Host "`n3️⃣ Teste 3: Função" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body3 -ContentType "application/json"
    Write-Host "Resultado:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
} 