# Script to generate dark.svg and light.svg for Sakthiprakash T's GitHub Banner

$darkPath = "d:\github readme\dark.svg"
$lightPath = "d:\github readme\light.svg"

function Build-Banner($isDark) {
    $bg = if ($isDark) { "#0A101F" } else { "#F8FAFC" }
    $cardBg = if ($isDark) { "#0F172A" } else { "#FFFFFF" }
    $cardBorder = if ($isDark) { "#0891B2" } else { "#0284C7" }
    $cardHeaderBg = if ($isDark) { "#1E293B" } else { "#F1F5F9" }
    $portraitColor = if ($isDark) { "#A78BFA" } else { "#7C3AED" }
    $textColor = if ($isDark) { "#E2E8F0" } else { "#0F172A" }
    $labelColor = if ($isDark) { "#22D3EE" } else { "#0284C7" }
    $dimTextColor = if ($isDark) { "#94A3B8" } else { "#475569" }
    $accentColor = "#10B981"
    $badgeBg = if ($isDark) { "rgba(16, 185, 129, 0.15)" } else { "rgba(16, 185, 129, 0.1)" }
    
    $rnd = New-Object System.Random(44710)
    $dotsSvg = New-Object System.Text.StringBuilder

    $numDots = 300

    for ($i = 0; $i -lt $numDots; $i++) {
        $groupIndex = $i % 60
        $shimmerDelay = [math]::Round(($groupIndex / 60.0) * 3.2, 2)
        
        # 1. Portrait Target (x, y) centered in left panel box [45..395, 110..550]
        if ($i -lt 70) {
            # Hair & Crown
            $angle = ($i / 70.0) * [math]::PI
            $px = 220 + [math]::Cos($angle) * (65 + ($rnd.NextDouble() * 15))
            $py = 170 - [math]::Sin($angle) * (65 + ($rnd.NextDouble() * 15))
        } elseif ($i -lt 150) {
            # Face contour & features (glasses, nose, chin)
            $row = [math]::Floor(($i - 70) / 10)
            $col = ($i - 70) % 10
            $px = 175 + ($col * 9) + ($rnd.NextDouble() * 4)
            $py = 180 + ($row * 10) + ($rnd.NextDouble() * 4)
        } elseif ($i -lt 240) {
            # Shoulders & Chest
            $fraction = ($i - 150) / 90.0
            $px = 80 + ($fraction * 280) + ($rnd.NextDouble() * 8)
            $py = 320 + [math]::Sin($fraction * [math]::PI) * 120 + ($rnd.NextDouble() * 15)
        } else {
            # AI Tech Aura
            $angle = ($i / 60.0) * 2 * [math]::PI
            $r = 130 + ($rnd.NextDouble() * 40)
            $px = 220 + [math]::Cos($angle) * $r
            $py = 300 + [math]::Sin($angle) * $r
        }
        
        $px = [math]::Max(55, [math]::Min(385, $px))
        $py = [math]::Max(120, [math]::Min(530, $py))

        # 2. Gemini Logo Target (Twin Star Sparkles)
        $signX = if ($rnd.Next(2) -eq 0) { 1 } else { -1 }
        $signY = if ($rnd.Next(2) -eq 0) { 1 } else { -1 }
        if ($i % 3 -ne 0) {
            # Main Sparkle Star (Center 220, 310)
            $dist = ($rnd.NextDouble() * 90)
            if ($i % 2 -eq 0) {
                $gx = 220 + ($signX * $dist * 1.1)
                $gy = 310 + ($rnd.NextDouble() * 10 - 5)
            } else {
                $gx = 220 + ($rnd.NextDouble() * 10 - 5)
                $gy = 310 + ($signY * $dist * 1.1)
            }
        } else {
            # Secondary Sparkle Star (Top Right 310, 210)
            $gx = 310 + ($rnd.NextDouble() * 40 - 20)
            $gy = 210 + ($rnd.NextDouble() * 40 - 20)
        }

        # 3. Vertex AI Logo Target (3D Ribbon Chevron V)
        $vFrac = $i / $numDots
        if ($vFrac -lt 0.5) {
            $vx = 120 + ($vFrac * 2 * 100) + ($rnd.NextDouble() * 12)
            $vy = 200 + ($vFrac * 2 * 200) + ($rnd.NextDouble() * 12)
        } else {
            $vx = 220 + (($vFrac - 0.5) * 2 * 100) + ($rnd.NextDouble() * 12)
            $vy = 400 - (($vFrac - 0.5) * 2 * 200) + ($rnd.NextDouble() * 12)
        }

        # 4. GitHub Logo Target (Octocat Silhouette Head)
        $ghAngle = ($i / $numDots) * 2 * [math]::PI
        $ghR = 85 + ($rnd.NextDouble() * 15)
        $hX = 220 + [math]::Cos($ghAngle) * $ghR
        $hY = 300 + [math]::Sin($ghAngle) * $ghR
        if ($i % 12 -eq 0) {
            $hX = 160 + ($rnd.NextDouble() * 30 - 15)
            $hY = 200 + ($rnd.NextDouble() * 30 - 15)
        } elseif ($i % 12 -eq 1) {
            $hX = 280 + ($rnd.NextDouble() * 30 - 15)
            $hY = 200 + ($rnd.NextDouble() * 30 - 15)
        }

        $fPx = "{0:F1}" -f $px
        $fPy = "{0:F1}" -f $py
        $fGx = "{0:F1}" -f $gx
        $fGy = "{0:F1}" -f $gy
        $fVx = "{0:F1}" -f $vx
        $fVy = "{0:F1}" -f $vy
        $fHx = "{0:F1}" -f $hX
        $fHy = "{0:F1}" -f $hY

        $dotSize = "{0:F1}" -f (2.2 + ($rnd.NextDouble() * 1.8))

        [void]$dotsSvg.AppendLine(@"
        <circle class="diter-dot dot-grp-$groupIndex" cx="$fPx" cy="$fPy" r="$dotSize" fill="$portraitColor" opacity="0">
            <animate attributeName="opacity" values="0;0.9;0.85" keyTimes="0; 0.5; 1" dur="0.8s" begin="${shimmerDelay}s" fill="freeze" />
            <animate attributeName="cx" values="$fPx; $fPx; $fGx; $fGx; $fVx; $fVx; $fHx; $fHx; $fPx" keyTimes="0; 0.22; 0.28; 0.47; 0.53; 0.72; 0.78; 0.94; 1" dur="14.2s" begin="3.2s" repeatCount="indefinite" />
            <animate attributeName="cy" values="$fPy; $fPy; $fGy; $fGy; $fVy; $fVy; $fHy; $fHy; $fPy" keyTimes="0; 0.22; 0.28; 0.47; 0.53; 0.72; 0.78; 0.94; 1" dur="14.2s" begin="3.2s" repeatCount="indefinite" />
        </circle>
"@)
    }

    $svgContent = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1180 610" width="1180" height="610">
  <defs>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700;800&amp;family=Inter:wght@400;600;700&amp;display=swap');
      
      .bg-rect { fill: $bg; }
      .font-mono { font-family: 'JetBrains Mono', monospace, Courier; }
      .font-sans { font-family: 'Inter', system-ui, -apple-system, sans-serif; }
      
      .card-main { fill: $cardBg; stroke: $cardBorder; stroke-width: 1.5; rx: 12; }
      .card-header { fill: $cardHeaderBg; rx: 12; }
      .text-title { fill: $textColor; font-weight: 700; font-size: 15px; }
      .text-label { fill: $labelColor; font-weight: 700; font-size: 12.5px; letter-spacing: 0.5px; }
      .text-val { fill: $textColor; font-weight: 500; font-size: 12.5px; }
      .text-dim { fill: $dimTextColor; font-size: 11.5px; }
      .text-accent { fill: $accentColor; font-weight: 700; }
      
      @keyframes pulse-glow {
        0% { opacity: 0.4; }
        50% { opacity: 1; }
        100% { opacity: 0.4; }
      }
      .live-dot { fill: $accentColor; animation: pulse-glow 2s infinite ease-in-out; }
      .diter-dot { transition: all 0.3s ease; }
    </style>

    <linearGradient id="panel-grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="$cardBg" stop-opacity="0.9" />
      <stop offset="100%" stop-color="$bg" stop-opacity="0.95" />
    </linearGradient>
    
    <linearGradient id="accent-line" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="$labelColor" />
      <stop offset="50%" stop-color="$portraitColor" />
      <stop offset="100%" stop-color="$accentColor" />
    </linearGradient>
  </defs>

  <!-- Background Canvas -->
  <rect class="bg-rect" width="1180" height="610" rx="16" />
  
  <!-- Outer Frame Accent Border -->
  <rect x="2" y="2" width="1176" height="606" fill="none" stroke="url(#accent-line)" stroke-width="1.5" rx="15" opacity="0.4" />

  <!-- LEFT PANEL: Animated Dithered Portrait & Logo Morph Frame -->
  <g transform="translate(10, 0)">
    <rect x="35" y="45" width="370" height="520" rx="14" fill="url(#panel-grad)" stroke="$cardBorder" stroke-width="1" opacity="0.6" />
    
    <path d="M 45 65 L 45 45 L 65 45" fill="none" stroke="$labelColor" stroke-width="2.5" />
    <path d="M 395 65 L 395 45 L 375 45" fill="none" stroke="$labelColor" stroke-width="2.5" />
    <path d="M 45 545 L 45 565 L 65 565" fill="none" stroke="$labelColor" stroke-width="2.5" />
    <path d="M 395 545 L 395 565 L 375 565" fill="none" stroke="$labelColor" stroke-width="2.5" />

    <text x="55" y="75" class="font-mono text-label" font-size="11" opacity="0.8">SYSTEM.PORTRAIT // LOGO.MORPH</text>
    <text x="310" y="75" class="font-mono text-dim" font-size="10">300×340</text>

    <!-- Dithered Dots Container -->
    <g id="portrait-dots">
      $($dotsSvg.ToString())
    </g>

    <!-- Morph Stage Identifier Pill -->
    <rect x="75" y="525" width="290" height="24" rx="12" fill="$badgeBg" stroke="$accentColor" stroke-width="1" opacity="0.8" />
    <text x="220" y="541" class="font-mono text-accent" font-size="11" text-anchor="middle">
      <tspan>MORPH: PORTRAIT </tspan>
      <tspan fill="$labelColor">↔ GEMINI ↔ VERTEX ↔ GITHUB</tspan>
    </text>
  </g>

  <!-- RIGHT PANEL: SYSTEM.INFO Terminal Card UI -->
  <g transform="translate(435, 45)">
    <rect class="card-main" x="0" y="0" width="705" height="520" />
    
    <!-- Top Terminal Bar -->
    <rect class="card-header" x="0" y="0" width="705" height="42" />
    <rect x="0" y="41" width="705" height="1" fill="$cardBorder" opacity="0.4" />
    
    <circle cx="22" cy="21" r="5.5" fill="#EF4444" opacity="0.85" />
    <circle cx="39" cy="21" r="5.5" fill="#F59E0B" opacity="0.85" />
    <circle cx="56" cy="21" r="5.5" fill="#10B981" opacity="0.85" />
    
    <text x="78" y="26" class="font-mono text-title">profile.sh --live</text>
    
    <g transform="translate(595, 11)">
      <rect x="0" y="0" width="88" height="22" rx="11" fill="$badgeBg" stroke="$accentColor" stroke-width="1" />
      <circle class="live-dot" cx="14" cy="11" r="4" />
      <text x="26" y="15" class="font-mono text-accent" font-size="11">● LIVE</text>
    </g>

    <!-- SYSTEM.INFO Terminal Grid Content -->
    <g transform="translate(25, 62)">
      <text x="0" y="18" class="font-mono text-label">Subject</text>
      <text x="140" y="18" class="font-sans text-val" font-weight="700" font-size="15" fill="$labelColor">SAKTHIPRAKASH T</text>
      
      <text x="0" y="44" class="font-mono text-label">Role</text>
      <text x="140" y="44" class="font-sans text-val">AI Engineer • AI Developer • Hackathon Builder</text>

      <text x="0" y="70" class="font-mono text-label">Origin</text>
      <text x="140" y="70" class="font-sans text-val">Puducherry, India</text>
      <text x="360" y="70" class="font-mono text-label">Education</text>
      <text x="455" y="70" class="font-sans text-val">B.Tech IT (SMVEC)</text>

      <text x="0" y="96" class="font-mono text-label">Status</text>
      <text x="140" y="96" class="font-sans text-accent">Building • Learning • Shipping 🚀</text>

      <line x1="0" y1="112" x2="655" y2="112" stroke="$cardBorder" stroke-width="1" stroke-dasharray="4 4" opacity="0.3" />

      <!-- TECH STACK MATRIX -->
      <text x="0" y="136" class="font-mono text-label">ToolChain</text>
      <text x="140" y="136" class="font-sans text-val">VS Code • Cursor AI • Git • Firebase Studio • Docker</text>

      <text x="0" y="162" class="font-mono text-label">Languages</text>
      <text x="140" y="162" class="font-sans text-val">Python • Java • JavaScript • TypeScript • C • SQL</text>

      <text x="0" y="188" class="font-mono text-label">Frontend</text>
      <text x="140" y="188" class="font-sans text-val">React • Next.js • Tailwind CSS • HTML5 • CSS3</text>

      <text x="0" y="214" class="font-mono text-label">Backend</text>
      <text x="140" y="214" class="font-sans text-val">FastAPI • Flask • Node.js • Express.js</text>

      <text x="0" y="240" class="font-mono text-label">Database</text>
      <text x="140" y="240" class="font-sans text-val">PostgreSQL • MongoDB • Firebase Firestore • SQLite</text>

      <text x="0" y="266" class="font-mono text-label">Core AI</text>
      <text x="140" y="266" class="font-sans text-val" fill="$portraitColor" font-weight="700">Google Gemini API • Vertex AI • LangChain • Ollama • RAG</text>

      <text x="0" y="292" class="font-mono text-label">Cloud / Infra</text>
      <text x="140" y="292" class="font-sans text-val">GCP • Firebase • Docker • Vercel • GitHub Actions</text>

      <line x1="0" y1="308" x2="655" y2="308" stroke="$cardBorder" stroke-width="1" stroke-dasharray="4 4" opacity="0.3" />

      <!-- CONTACT DIRECTORY -->
      <text x="0" y="332" class="font-mono text-label">Mail</text>
      <text x="140" y="332" class="font-mono text-val" font-size="12">sakthiprakashthangaraj@gmail.com</text>

      <text x="0" y="358" class="font-mono text-label">Portfolio</text>
      <text x="140" y="358" class="font-mono text-val" font-size="12" fill="$labelColor">portfolio-six-wheat-wig4lpjmp7.vercel.app</text>

      <text x="0" y="384" class="font-mono text-label">LinkedIn</text>
      <text x="140" y="384" class="font-mono text-val" font-size="12">linkedin.com/in/sakthi-prakash-44710</text>

      <text x="0" y="410" class="font-mono text-label">GitHub</text>
      <text x="140" y="410" class="font-mono text-val" font-size="12">github.com/sakthi44710 <tspan fill="$accentColor">(@sakthi44710)</tspan></text>
      
      <text x="0" y="442" class="font-mono text-dim" font-size="11">&gt; STATUS: ONLINE // AI OS ACTIVE // READY TO COLLABORATE_</text>
    </g>
  </g>
</svg>
"@

    return $svgContent
}

Set-Content -Path $darkPath -Value (Build-Banner -isDark $true) -Encoding UTF8
Set-Content -Path $lightPath -Value (Build-Banner -isDark $false) -Encoding UTF8
Write-Output "Banners dark.svg and light.svg generated successfully!"
