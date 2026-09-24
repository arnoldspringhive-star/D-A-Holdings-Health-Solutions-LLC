import os
import glob
import re

base_dir = r"c:\Users\IT\Documents\Anti Gravity\D & A Holdings Health Solutions LLC"
html_files = glob.glob(os.path.join(base_dir, "*.html"))

header_desktop_old = r'<img src="images/brand_logo.png" alt="D &amp; A Holdings Health Solutions LLC"\s*style="height: 52px; width: auto; object-fit: contain; display: block;">'
header_desktop_new = r'''<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 80px; width: auto; object-fit: contain; display: block;">'''

header_mobile_old = r'<img src="images/brand_logo.png" alt="D &amp; A Holdings Health Solutions LLC"\s*style="height: 42px; width: auto; object-fit: contain; display: block;">'
header_mobile_new = r'''<img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                    style="height: 60px; width: auto; object-fit: contain; display: block;">'''

footer_old = r'''<a href="index2\.html" class="brand-logo footer-logo"\s*style="flex-direction: row; align-items: center; gap: 14px; margin-bottom: 20px;">\s*<div\s*style="background-color: var\(--clr-white\); padding: 6px; border-radius: 10px; display: flex; align-items: center; justify-content: center; width: 50px; height: 50px; flex-shrink: 0;">\s*<img src="images/brand_icon\.png" alt="D&amp;A Holdings Logo Icon"\s*style="max-width: 100%; max-height: 100%; object-fit: contain;">\s*</div>\s*<div style="display: flex; flex-direction: column; justify-content: center;">\s*<span class="brand-name" style="line-height: 1\.1;">D &amp; A HOLDINGS</span>\s*<span class="brand-sub">HEALTH SOLUTIONS LLC</span>\s*</div>\s*</a>'''

footer_new = r'''<a href="index2.html" class="brand-logo footer-logo" style="margin-bottom: 20px; display: block;">
                        <img src="images/da_logo.png" alt="D &amp; A Holdings Health Solutions LLC"
                            style="max-width: 350px; height: auto; object-fit: contain; display: block; background-color: var(--clr-white); padding: 10px; border-radius: 8px;">
                    </a>'''

for file in html_files:
    if file.endswith('index2.html'):
        continue # already updated
        
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content
    
    # regex replacements
    content = re.sub(header_desktop_old, header_desktop_new, content)
    content = re.sub(header_mobile_old, header_mobile_new, content)
    content = re.sub(footer_old, footer_new, content)
    
    if content != original:
        with open(file, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {os.path.basename(file)}")

