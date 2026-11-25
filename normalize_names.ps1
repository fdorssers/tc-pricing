# Aligns plant names (Genus + Variety) across suppliers in prices.csv.
# Usage:  pwsh ./normalize_names.ps1 [-In prices.csv] [-Out prices.csv]
# Writes name_mapping.csv (old -> new) next to the output for review.
# The Name column is left untouched (it holds the supplier's original text).
param([string]$In = "prices.csv", [string]$Out = "prices.csv")

$genusFix = @{
    'alocsia' = 'Alocasia'; 'anturium' = 'Anthurium'; 'philodedron' = 'Philodendron'
    'rhaphidhora' = 'Rhaphidophora'; 'scandapsus' = 'Scindapsus'; 'traumatophyllum' = 'Thaumatophyllum'
}

# Applied in order to the lower-cased variety (regex => replacement).
$wordFix = [ordered]@{
    '\bsatun\b' = 'saturn'; 'cuculatta' = 'cucullata'; 'golgen' = 'golden'; 'geunea' = 'guinea'
    '\blighs\b' = 'lights'; 'sturdust' = 'stardust'; 'psuedo' = 'pseudo'
    '\bregal shiel(d)?s\b' = 'regal shield'; '\breginea\b|\bregina\b' = 'reginae'
    'triangularus' = 'triangularis'; 'wentti' = 'wentii'; '\bolani\b' = 'olanii'; 'longilabo' = 'longiloba'
    '\bmacrorrhiza\b' = 'macrorrhizos'; '\bportora\b|\bportadora\b' = 'portodora'; '\bsliver\b' = 'silver'
    "\bdragon'?s? breath\b" = "dragon's breath"; '\bdragon wings\b' = 'dragon wing'; "\bdragon tooth's\b" = 'dragon tooth'
    '\bnairobi night\b' = 'nairobi nights'; 'clarinervum' = 'clarinervium'; 'papillilanium' = 'papillilaminum'
    '\bpapi\b' = 'papillilaminum'; '\baos\b' = 'ace of spades'; '\bace of heart\b' = 'ace of hearts'
    '\bqueen of heart\b' = 'queen of hearts'; '\bhybride\b' = 'hybrid'; '\bhybid\b' = 'hybrid'
    '\bsilver brush\b' = 'silver blush'; 'vittarifolium' = 'vittariifolium'; '\bkuth\b' = 'kunth'
    '\bwonder boy\b' = 'wonderboy'; 'darthvaderana' = 'darthvaderiana'; '\bblack bate\b' = 'black bat'
    '\brubby\b' = 'ruby'; '^sp hairy' = 'sp. hairy'; 'billitiae' = 'billietiae'; 'black cardiani' = 'black cardinal'
    'joppeii' = 'joepii'; '\bwipple\b' = 'whipple'; '\bred imperial\b' = 'imperial red'; '\bx bob\b(?! cee)' = 'x bob cee'
    '^cv\. ' = ''; 'unnilae|unniiae' = 'uniiae'; 'sieranna' = 'sierrana'; '\bstarlord\b' = 'star lord'
    '\btatto\b' = 'tattoo'; 'creme brulee' = 'crème brûlée'; '\belectro ?light\b' = 'electrolyte'
    'peltatoradiatum' = 'pedatoradiatum'; 'pallidiflorum ford sherman' = 'papillilaminum fort sherman'
    'lago gatun' = 'lago gatún'; 'sectoral ?/ ?blocky' = 'sectoral'; '\(pre-order\)' = ''
    '^black magic\(.*\)$' = 'black magic'; '\bgold latte\b|\blatte gold\b' = 'golden latte'
    '\brouge pink\b' = 'pink rouge'; '^clarinervium dorayaki$' = 'clarinervium x dorayaki'
    '\(grade a\)' = 'grade a'; '\(green\)?' = ''; '\(green$' = ''; 'tri-color' = 'tricolor'
    '\bpink ?/ ?albo\b|\balbo ?/ ?pink\b|\bpink albo\b|\balbo pink\b' = 'albo/pink'
    '\bpink ?/ ?mint\b|\bmint ?/ ?pink\b|\bpink mint\b' = 'mint/pink'
}

# Botanical "var." (not variegation) – leave these varieties alone for the var rule.
$botanicalVar = 'var nishikiran|var\. nigrescens'
$aroids = 'Alocasia','Anthurium','Monstera','Philodendron','Homalomena','Thaumatophyllum','Xanthosoma'

# Final merges after normalisation: "Genus|Variety" => "Genus|Variety"
$merge = @{
    'Alocasia|Longiloba Black Saturn Pink Bone'          = 'Alocasia|Black Saturn Pink Bone'
    'Alocasia|Parasol / Alocasia Mandalay Albo/Pink Variegated' = 'Alocasia|Parasol Pink Variegated'
    'Alocasia|Pink Dragon Mint Stardust Variegated'      = 'Alocasia|Pink Dragon Stardust Mint Variegated'
    'Alocasia|Mickey Mouse'                              = 'Xanthosoma|Mickey Mouse'
    'Alocasia|Xanthosoma Mickey Mouse Variegated'        = 'Xanthosoma|Mickey Mouse Variegated'
    'Philodendron|Xanthosoma Lindenii Variegated'        = 'Xanthosoma|Lindenii Variegated'
    'Philodendron|Thaumatophyllum Bipinnatifidum Aurea Variegated' = 'Thaumatophyllum|Bipinnatifidum Aurea Variegated'
    'Philodendron|Bipinnatifidum Aurea Variegated'       = 'Thaumatophyllum|Bipinnatifidum Aurea Variegated'
    'Philodendron|Pastazanum Silver Aurea Hybrid Variegated' = 'Philodendron|Pastazanum Silver Hybrid Aurea Variegated'
    'Anthurium|Ace Of Spades Variegated X Papillilaminum' = 'Anthurium|Ace Of Spades X Papillilaminum Variegated'
    'Anthurium|Black Blush X Ace Of Hearts X Tezula Red Crystallinum' = 'Anthurium|(Black Blush X Ace Of Hearts) X Tezula Red Crystallinum'
    "Anthurium|Pallidiflorum Lago Gatún X (Pallidiflorum Fort Sherham X Red Vein Dark Phoenix)" = 'Anthurium|Papillilaminum Lago Gatún X (Papillilaminum Fort Sherman X Red Vein Dark Phoenix)'
    'Anthurium|Napo'                                     = 'Anthurium|Sp Napo'
    'Begonia|Exotica (Begonia Brevirimosa Subsp.)'       = 'Begonia|Brevirimosa Exotica'
    'Monstera|Albo Variegated'                           = 'Monstera|Borsigiana Albo Variegated'
    'Monstera|Borsigiana Full Mint (Thailand)'           = 'Monstera|Borsigiana Full Mint'
    'Monstera|Full Mint (Borsigiana Thailand)'           = 'Monstera|Borsigiana Full Mint'
    'Monstera|Lime Light'                                = 'Monstera|Lime Light'
    'Monstera|Thai Constellation'                        = 'Monstera|Deliciosa Thai Constellation Variegated'
    'Monstera|Thai Constellation Variegated'             = 'Monstera|Deliciosa Thai Constellation Variegated'
    'Monstera|Deliciosa Mint (Thailand) Variegated'      = 'Monstera|Deliciosa Mint Variegated'
    'Monstera|Thai Constellation High Variegated'        = 'Monstera|Deliciosa Thai Constellation High Variegated'
    'Monstera|Thai Constellation Miracle Tricolor (High) Variegated' = 'Monstera|Deliciosa Thai Constellation Miracle Tricolor High Variegated'
    'Monstera|Bulbasaur High Variegated'                 = 'Monstera|Deliciosa Bulbasaur High Variegated'
    'Monstera|Bulbasaur Premium Variegated'              = 'Monstera|Deliciosa Bulbasaur Premium Variegated'
    'Philodendron|Verrucosum Mint (Holland) Variegated'  = 'Philodendron|Verrucosum Mint Variegated'
    'Philodendron|Caramel Marble Pink Variegated'        = 'Philodendron|Caramel Marble Pink'
    'Philodendron|Imperial Red Full Orange'              = 'Philodendron|Imperial Red Full Orange Variegated'
    'Philodendron|Red Heart Full Pink'                   = 'Philodendron|Red Heart Full Pink Variegated'
    'Philodendron|Whipple Way Variegated'                = 'Philodendron|Whipple Way'
    'Alocasia|Watsoniana Mint/Pink (Glossy) Variegated'  = 'Alocasia|Watsoniana Glossy Mint/Pink Variegated'
    'Alocasia|Polly X Watsoniana (Alocasia Golden Shield) Variegated' = 'Alocasia|Polly X Watsoniana Variegated'
    "Alocasia|Dragon's Breath Albo Variegated"           = "Alocasia|Heterophylla Dragon's Breath Albo Variegated"
    "Alocasia|Dragon's Breath Aurea Variegated"          = "Alocasia|Heterophylla Dragon's Breath Aurea Variegated"
    'Anthurium|Luxurian Variegated'                      = 'Anthurium|Luxurians Variegated'
}
# Monstera cultivars Tea & Sarah list without "Deliciosa" while others include it.
foreach ($m in 'Bulbasaur','Devil Monster','Devil Monster Grade A','Electrolyte','Electrolyte Tricolor Variegated',
               'Green Snow','Legacy','Lemon Lime','Lemon Pom Pom','Melancholy','Mint Variegated','Star Shadow',
               'Tattoo','White Monster','Crème Brûlée','Thai Constellation Crème Brûlée',
               'Thai Constellation Miracle Tricolor Variegated') {
    $merge["Monstera|$m"] = "Monstera|Deliciosa $m"
}
$merge['Monstera|Deliciosa Devil Monster Grade A'] = 'Monstera|Deliciosa Devil Monster Grade A'
$merge["Monstera|Deliciosa Devil's Monster"] = 'Monstera|Deliciosa Devil Monster'

$ti = (Get-Culture).TextInfo

function Normalize([string]$genus, [string]$variety) {
    $g = $genus.Trim()
    if ($genusFix.ContainsKey($g.ToLower())) { $g = $genusFix[$g.ToLower()] }
    $g = $ti.ToTitleCase($g.ToLower())

    $v = $variety.Trim().ToLower()
    $v = $v -replace '["“”]', '' -replace '×', 'x'
    $v = $v -replace "'(?!s\b)", '' -replace "(?<![a-z])'", ''     # keep possessive 's only
    $v = $v -replace '\s+', ' '
    foreach ($k in $wordFix.Keys) { $v = $v -replace $k, $wordFix[$k] }

    if ($v -notmatch $botanicalVar) {
        $v = $v -replace '\bvar\b\.?', 'variegated'
    }
    $v = $v -replace '\bvariegat(a|um)\b', 'variegated'

    # One "variegated", always at the end.
    if ($v -match '\bvariegated\b' -and $v -notmatch $botanicalVar) {
        $v = ($v -replace '\bvariegated\b', '' -replace '\s+', ' ').Trim() + ' variegated'
    }
    # Albo/Aurea/Mint/Tricolor/Lava/Stardust on aroids imply variegation.
    if ($aroids -contains $g -and $v -match '\b(albo|aurea|mint|tricolor|lava|stardust)\b' -and
        $v -notmatch '\bvariegated\b' -and $v -notmatch 'full mint') {
        $v = "$v variegated"
    }
    $v = ($v -replace '\s+', ' ' -replace '\(\s+', '(' -replace '\s+\)', ')').Trim(' ', '.', ',', '/')
    $v = $ti.ToTitleCase($v) -replace "'S\b", "'s"

    $key = "$g|$v"
    if ($merge.ContainsKey($key)) { $g, $v = $merge[$key] -split '\|', 2 }
    return $g, $v
}

function Format-Field([string]$s) {
    if ($s -match '[",\r\n]') { return '"' + ($s -replace '"', '""') + '"' }
    return $s
}

$rows = Import-Csv $In -Encoding utf8
$cols = $rows[0].PSObject.Properties.Name
$map = @{}
foreach ($r in $rows) {
    $g, $v = Normalize $r.Genus $r.Variety
    $map["$($r.Genus)|$($r.Variety)"] = [pscustomobject]@{ OldGenus = $r.Genus; OldVariety = $r.Variety; NewGenus = $g; NewVariety = $v }
    $r.Genus = $g; $r.Variety = $v
}

$lines = [Collections.Generic.List[string]]::new()
$lines.Add(($cols -join ','))
foreach ($r in $rows) { $lines.Add((($cols | ForEach-Object { Format-Field $r.$_ }) -join ',')) }
$outFull = [IO.Path]::GetFullPath($Out, (Get-Location).Path)
[IO.File]::WriteAllText($outFull, ($lines -join "`r`n") + "`r`n", [Text.UTF8Encoding]::new($false))

$map.Values | Where-Object { $_.OldGenus -cne $_.NewGenus -or $_.OldVariety -cne $_.NewVariety } |
    Sort-Object NewGenus, NewVariety, OldVariety |
    Export-Csv (Join-Path (Split-Path $outFull -Parent) 'name_mapping.csv') -NoTypeInformation -Encoding utf8
