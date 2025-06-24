# Teste específico para JavaScript Strategy
$API_URL = "http://172.19.144.1:3000/api"

Write-Host "🧪 Teste JavaScript Strategy" -ForegroundColor Green

# Teste JavaScript simples
$body = @{
    strategy = "javascript"
    url = "https://httpbin.org/html"
    script = "({ title: document.title, url: window.location.href, hasBody: !!document.body })"
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri "$API_URL/scrape" -Method Post -Body $body -ContentType "application/json"
    Write-Host "Resultado:" -ForegroundColor Yellow
    $response | ConvertTo-Json -Depth 3
} catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Red
    }
} 