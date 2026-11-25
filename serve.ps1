# Minimal static file server for previewing index.html locally.
# Usage: pwsh ./serve.ps1 [-Port 8765]   then open http://localhost:8765/
param([int]$Port = 8765)

# Trailing separator so a sibling folder like "tc-pricing-old" doesn't pass the "inside root" check.
$root = $PSScriptRoot.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
$types = @{ '.html' = 'text/html; charset=utf-8'; '.csv' = 'text/csv; charset=utf-8'; '.js' = 'text/javascript'; '.css' = 'text/css'; '.json' = 'application/json' }
# Use the requested port, or the next free one if it's taken (e.g. by another running copy).
$listener = $null
foreach ($p in $Port..($Port + 9)) {
    $candidate = [Net.HttpListener]::new()
    $candidate.Prefixes.Add("http://localhost:$p/")
    try { $candidate.Start(); $listener = $candidate; break }
    catch { $candidate.Close(); Write-Host "Port $p is in use, trying $($p + 1)..." }
}
if (-not $listener) { Write-Error "No free port between $Port and $($Port + 9). Pass another one with -Port."; exit 1 }
$Port = [int]($listener.Prefixes | Select-Object -First 1).Split(':')[2].TrimEnd('/')
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
