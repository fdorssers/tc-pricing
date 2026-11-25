# Checks prices.csv for typos before committing new price rows.
# Usage: pwsh ./check.ps1 [-Path prices.csv]   (exit code 1 when something is wrong)
param([string]$Path = "prices.csv")

$price = '^(€ \d+\.\d{2}|not available|)$'   # "€ 12.34", "not available" or empty
$problems = @()
$line = 1   # header is line 1
foreach ($r in Import-Csv $Path -Encoding utf8) {
    $line++
    if ($r.Date -notmatch '^\d{2}-\d{2}-\d{4}$') { $problems += "line ${line}: date '$($r.Date)' is not dd-mm-yyyy" }
    foreach ($col in 'Genus', 'Variety', 'Supplier') {
        if (-not $r.$col.Trim()) { $problems += "line ${line}: $col is empty" }
    }
    foreach ($col in 'Price/Bag', 'Price/Plant') {
        # -notmatch ignores case, so "Not Available" passes too.
        if ($r.$col -notmatch $price) { $problems += "line ${line}: $col '$($r.$col)' should look like '€ 12.34'" }
    }
    if (-not $r.'Price/Bag' -and -not $r.'Price/Plant') { $problems += "line ${line}: no price at all" }
}

if ($problems) { $problems; "`n$($problems.Count) problem(s) in $Path"; exit 1 }
"$Path looks fine ($($line - 1) rows)"
exit 0
