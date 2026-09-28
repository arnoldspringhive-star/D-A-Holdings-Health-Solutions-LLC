from PIL import Image, ImageChops
import os

def trim(im):
    # Get the background color from the top-left corner
    bg_color = im.getpixel((0,0))
    bg = Image.new(im.mode, im.size, bg_color)
    diff = ImageChops.difference(im, bg)
    if diff.mode == 'RGBA':
        diff = diff.convert('RGB')
    
    # Bounding box of the non-background area
    bbox = diff.getbbox()
    if bbox:
        # Add a small padding (e.g. 10px) to the bbox so it's not completely flush
        padding = 10
        left = max(0, bbox[0] - padding)
        top = max(0, bbox[1] - padding)
        right = min(im.width, bbox[2] + padding)
        bottom = min(im.height, bbox[3] + padding)
        return im.crop((left, top, right, bottom))
    return im

paths = ["images/brand_logo.png", "images/da_logo.png", "images/logo.png"]
for p in paths:
    if os.path.exists(p):
        try:
            im = Image.open(p).convert("RGBA")
            
            # First try to see if there is transparent whitespace
            alpha = im.getchannel('A')
            alpha_bbox = alpha.getbbox()
            
            # If the image is entirely transparent or fully opaque, getbbox returns None or full size
            # Let's crop by color difference
            cropped = trim(im)
            cropped.save(p)
            print(f"Cropped {p}")
        except Exception as e:
            print(f"Failed {p}: {e}")
