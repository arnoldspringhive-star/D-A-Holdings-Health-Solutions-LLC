$dir = "c:\Users\IT\Documents\Anti Gravity\D & A Holdings Health Solutions LLC"
$files = Get-ChildItem -Path $dir -Filter "*.html" | Where-Object { $_.Name -ne "index2.html" }

$header_desktop_regex = '(?s)<img src="images/brand_logo\.png" alt="D &amp; A Holdings Health Solutions LLC"\s*style="height: 52px; width: auto; object-fit: contain; display: block;">'
$header_desktop_new = '<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC" style="height: 80px; width: auto; object-fit: contain; display: block;">'

$header_mobile_regex = '(?s)<img src="images/brand_logo\.png" alt="D &amp; A Holdings Health Solutions LLC"\s*style="height: 42px; width: auto; object-fit: contain; display: block;">'
$header_mobile_new = '<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC" style="height: 60px; width: auto; object-fit: contain; display: block;">'

$footer_regex = '(?s)<a href="index2\.html" class="brand-logo footer-logo".*?</a>'
$footer_new = '<a href="index2.html" class="brand-logo footer-logo" style="margin-bottom: 20px; display: block;">
                        <img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                            style="max-width: 350px; height: auto; object-fit: contain; display: block; background-color: var(--clr-white); padding: 10px; border-radius: 8px;">
                    </a>'

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $original = $content

    $content = [regex]::Replace($content, $header_desktop_regex, $header_desktop_new)
    $content = [regex]::Replace($content, $header_mobile_regex, $header_mobile_new)
    $content = [regex]::Replace($content, $footer_regex, $footer_new)

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($file.Name)"
    }
}
