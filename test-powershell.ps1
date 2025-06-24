# Teste da APIBR no PowerShell
$API_URL = "http://172.19.144.1:3000/api"

Write-Host "🧪 Testando APIBR - PowerShell" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Teste 1: Informações da API
Write-Host "`n1️⃣ Testando endpoint de informações da API..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL" -Method Get
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 2: Scraping básico
Write-Host "`n2️⃣ Testando scraping básico (example.com)..." -ForegroundColor Yellow
$body = @{
    strategy = "basic"
    url = "https://example.com"
    selectors = @{
        title = @{
            query = "h1"
        }
        paragraph = @{
            query = "p"
        }
    }
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 3: JavaScript strategy
Write-Host "`n3️⃣ Testando JavaScript strategy (Google)..." -ForegroundColor Yellow
$body = @{
    strategy = "javascript"
    url = "https://www.google.com"
    script = "document.title + ' - ' + window.location.href"
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body -ContentType "application/json"
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 4: Screenshot
Write-Host "`n4️⃣ Testando screenshot..." -ForegroundColor Yellow
$body = @{
    strategy = "screenshot"
    url = "https://example.com"
    screenshotOptions = @{
        fullPage = $false
        type = "png"
    }
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body -ContentType "application/json"
    Write-Host "Screenshot base64 length: $($response.data.screenshot.Length)" -ForegroundColor Green
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 5: Estatísticas
Write-Host "`n5️⃣ Testando estatísticas do pool..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape/stats" -Method Get
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n✅ Testes concluídos!" -ForegroundColor Green 