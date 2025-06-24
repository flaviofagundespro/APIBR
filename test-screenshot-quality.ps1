# Teste de qualidade de screenshots
$API_URL = "http://172.19.144.1:3000/api"

Write-Host "📸 Teste de Qualidade de Screenshots" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Teste 1: PNG (qualidade máxima)
Write-Host "`n1️⃣ PNG - Qualidade Máxima" -ForegroundColor Yellow
$body1 = @{
    strategy = "screenshot"
    url = "https://example.com"
    screenshotOptions = @{
        fullPage = $false
        type = "png"
    }
} | ConvertTo-Json -Depth 3

try {
    $response1 = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body1 -ContentType "application/json"
    Write-Host "PNG size: $($response1.data.screenshot.Length) bytes" -ForegroundColor Green
} catch {
    Write-Host "Erro PNG: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 2: JPEG Qualidade 90
Write-Host "`n2️⃣ JPEG - Qualidade 90" -ForegroundColor Yellow
$body2 = @{
    strategy = "screenshot"
    url = "https://example.com"
    screenshotOptions = @{
        fullPage = $false
        type = "jpeg"
        quality = 90
    }
} | ConvertTo-Json -Depth 3

try {
    $response2 = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body2 -ContentType "application/json"
    Write-Host "JPEG 90 size: $($response2.data.screenshot.Length) bytes" -ForegroundColor Green
} catch {
    Write-Host "Erro JPEG 90: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 3: JPEG Qualidade 50
Write-Host "`n3️⃣ JPEG - Qualidade 50" -ForegroundColor Yellow
$body3 = @{
    strategy = "screenshot"
    url = "https://example.com"
    screenshotOptions = @{
        fullPage = $false
        type = "jpeg"
        quality = 50
    }
} | ConvertTo-Json -Depth 3

try {
    $response3 = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body3 -ContentType "application/json"
    Write-Host "JPEG 50 size: $($response3.data.screenshot.Length) bytes" -ForegroundColor Green
} catch {
    Write-Host "Erro JPEG 50: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 4: JPEG Qualidade 100
Write-Host "`n4️⃣ JPEG - Qualidade 100" -ForegroundColor Yellow
$body4 = @{
    strategy = "screenshot"
    url = "https://example.com"
    screenshotOptions = @{
        fullPage = $false
        type = "jpeg"
        quality = 100
    }
} | ConvertTo-Json -Depth 3

try {
    $response4 = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body4 -ContentType "application/json"
    Write-Host "JPEG 100 size: $($response4.data.screenshot.Length) bytes" -ForegroundColor Green
} catch {
    Write-Host "Erro JPEG 100: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n✅ Testes de qualidade concluídos!" -ForegroundColor Green 