$dir = "c:\Users\IT\Documents\Anti Gravity\D & A Holdings Health Solutions LLC"
$files = Get-ChildItem -Path $dir -Filter "*.html" | Where-Object { $_.Name -ne "index2.html" }

$header_desktop_old = '<img src="images/brand_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 52px; width: auto; object-fit: contain; display: block;">'

$header_desktop_new = '<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 80px; width: auto; object-fit: contain; display: block;">'

$header_mobile_old = '<img src="images/brand_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 42px; width: auto; object-fit: contain; display: block;">'

$header_mobile_new = '<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 60px; width: auto; object-fit: contain; display: block;">'

$footer_old = '<a href="index2.html" class="brand-logo footer-logo"
                        style="flex-direction: row; align-items: center; gap: 14px; margin-bottom: 20px;">
                        <div
                            style="background-color: var(--clr-white); padding: 6px; border-radius: 10px; display: flex; align-items: center; justify-content: center; width: 50px; height: 50px; flex-shrink: 0;">
                            <img src="images/brand_icon.png" alt="D&amp;A Holdings Logo Icon"
                                style="max-width: 100%; max-height: 100%; object-fit: contain;">
                        </div>
                        <div style="display: flex; flex-direction: column; justify-content: center;">
                            <span class="brand-name" style="line-height: 1.1;">D &amp; A HOLDINGS</span>
                            <span class="brand-sub">HEALTH SOLUTIONS LLC</span>
                        </div>
                    </a>'

$footer_new = '<a href="index2.html" class="brand-logo footer-logo" style="margin-bottom: 20px; display: block;">
                        <img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                            style="max-width: 350px; height: auto; object-fit: contain; display: block; background-color: var(--clr-white); padding: 10px; border-radius: 8px;">
                    </a>'

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $original = $content

    $content = $content.Replace($header_desktop_old, $header_desktop_new)
    $content = $content.Replace($header_mobile_old, $header_mobile_new)
    $content = $content.Replace($footer_old, $footer_new)

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.Name)"
    }
}
