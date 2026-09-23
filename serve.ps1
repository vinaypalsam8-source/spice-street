# Spice Street - Dedicated Local Web & API Server
# Powershell HttpListener with REST API for Orders & Status Sync
param (
    [int]$Port = 8080,
    [string]$Path = "C:\Users\Vinay\.gemini\antigravity\scratch\spice-street"
)

$ordersFile = Join-Path $Path "orders.json"
if (-not (Test-Path $ordersFile)) {
    "[]" | Out-File -FilePath $ordersFile -Encoding utf8
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:" + $Port + "/")
$listener.Prefixes.Add("http://127.0.0.1:" + $Port + "/")

try {
    $listener.Start()
    Write-Host "=======================================================" -ForegroundColor Cyan
    Write-Host "  SPICE STREET RESTAURANT SERVER IS ONLINE & RUNNING!" -ForegroundColor Green
    Write-Host ("  Website URL: http://localhost:" + $Port) -ForegroundColor Yellow
    Write-Host ("  Root Directory: " + $Path) -ForegroundColor Gray
    Write-Host "=======================================================" -ForegroundColor Cyan
} catch {
    Write-Error ("Failed to start listener on port " + $Port + ": " + $_.Exception.Message)
    exit 1
}

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
}

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $response.AddHeader("Access-Control-Allow-Origin", "*")
        $response.AddHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        $response.AddHeader("Access-Control-Allow-Headers", "Content-Type")

        if ($request.HttpMethod -eq "OPTIONS") {
            $response.StatusCode = 200
            $response.Close()
            continue
        }

        $localPath = $request.Url.LocalPath

        # API Endpoints
        if ($localPath -eq "/api/orders") {
            if ($request.HttpMethod -eq "GET") {
                $content = Get-Content -Path $ordersFile -Raw -Encoding utf8
                $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
                $response.StatusCode = 200
                $response.ContentType = "application/json; charset=utf-8"
                $response.ContentLength64 = $bytes.Length
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
            } elseif ($request.HttpMethod -eq "POST") {
                $reader = New-Object System.IO.StreamReader($request.InputStream, [System.Text.Encoding]::UTF8)
                $body = $reader.ReadToEnd()
                $reader.Close()

                $existing = Get-Content -Path $ordersFile -Raw -Encoding utf8
                $list = $existing | ConvertFrom-Json
                if (-not $list) { $list = @() }

                $newOrder = $body | ConvertFrom-Json
                # Filter out existing with same ID
                $filtered = @($list | Where-Object { $_.orderId -ne $newOrder.orderId })
                $filtered = @($newOrder) + $filtered

                $updatedJson = $filtered | ConvertTo-Json -Depth 10
                $updatedJson | Out-File -FilePath $ordersFile -Encoding utf8

                $resBytes = [System.Text.Encoding]::UTF8.GetBytes('{"status":"success","message":"Order synced"}')
                $response.StatusCode = 200
                $response.ContentType = "application/json"
                $response.ContentLength64 = $resBytes.Length
                $response.OutputStream.Write($resBytes, 0, $resBytes.Length)
            }
            $response.OutputStream.Flush()
            $response.Close()
            continue
        }

        # Static file delivery
        if ($localPath -eq "/" -or $localPath -eq "") {
            $localPath = "/index.html"
        }

        $cleanRelPath = $localPath.TrimStart("/").Replace("/", "\")
        $filePath = Join-Path $Path $cleanRelPath

        if (Test-Path -Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = "application/octet-stream"
            if ($mimeTypes.ContainsKey($ext)) { 
                $mime = $mimeTypes[$ext] 
            }

            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $response.StatusCode = 200
            $response.ContentType = $mime
            $response.ContentLength64 = $bytes.Length
            if ($request.HttpMethod -ne "HEAD") {
                $response.OutputStream.Write($bytes, 0, $bytes.Length)
            }
        } else {
            $response.StatusCode = 404
            $notFoundBytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: " + $localPath)
            $response.ContentType = "text/plain; charset=utf-8"
            $response.ContentLength64 = $notFoundBytes.Length
            if ($request.HttpMethod -ne "HEAD") {
                $response.OutputStream.Write($notFoundBytes, 0, $notFoundBytes.Length)
            }
        }
        $response.OutputStream.Flush()
        $response.Close()
    } catch {
        # Loop protection
    }
}
