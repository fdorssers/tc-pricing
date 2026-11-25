# Minimal static file server for previewing index.html locally.
# Usage: pwsh ./serve.ps1 [-Port 8765]   then open http://localhost:8765/
param([int]$Port = 8765)

$root = $PSScriptRoot
$types = @{ '.html' = 'text/html; charset=utf-8'; '.csv' = 'text/csv; charset=utf-8'; '.js' = 'text/javascript'; '.css' = 'text/css'; '.json' = 'application/json' }
$listener = [Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Serving $root at http://localhost:$Port/ (Ctrl+C to stop)"
try {
    while ($listener.IsListening) {
        $ctx = $listener.GetContext()
        $res = $ctx.Response
        try {
            $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
            if (-not $rel) { $rel = 'index.html' }
            $path = [IO.Path]::GetFullPath((Join-Path $root $rel))
            if ($path.StartsWith($root, [StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $path -PathType Leaf)) {
                $bytes = [IO.File]::ReadAllBytes($path)
                $res.ContentType = $types[[IO.Path]::GetExtension($path).ToLower()] ?? 'application/octet-stream'
                $res.Headers['Cache-Control'] = 'no-cache'
                $res.ContentLength64 = $bytes.Length
                if ($ctx.Request.HttpMethod -ne 'HEAD') { $res.OutputStream.Write($bytes, 0, $bytes.Length) }
            } else {
                $res.StatusCode = 404
            }
        } catch {
            Write-Warning "$($ctx.Request.Url): $_"
        } finally {
            try { $res.Close() } catch {}
        }
    }
} finally { $listener.Stop() }
