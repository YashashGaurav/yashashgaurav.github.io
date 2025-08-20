# Image Assets for Yashash Gaurav's Website

## Required Images

Place the following images in the `static/` directory:

### Profile and Branding
- `static/images/profile.jpg` - Your profile photo (120x120px recommended)
- `static/images/og-image.jpg` - Open Graph image for social sharing (1200x630px recommended)

### Favicons
- `static/favicon.ico` - Main favicon
- `static/favicon-16x16.png` - 16x16 favicon
- `static/favicon-32x32.png` - 32x32 favicon
- `static/apple-touch-icon.png` - Apple touch icon (180x180px)
- `static/safari-pinned-tab.svg` - Safari pinned tab icon (SVG format)

## Post Images

For blog post images, you can either:

1. **Use static/images/**: `![Alt text](/images/post-image.jpg)`
2. **Use page bundles**: Create a folder for your post and include images there

Example page bundle structure:
```
content/posts/my-awesome-post/
├── index.md
├── featured-image.jpg
└── diagram.png
```

## Image Optimization Tips

- Use WebP format when possible for better compression
- Optimize images before uploading (recommended tools: TinyPNG, ImageOptim)
- Profile image: 120x120px or 240x240px for retina displays
- Open Graph image: 1200x630px
- Keep file sizes under 1MB for better performance

## Favicon Generation

You can generate favicons from a single high-resolution image using:
- [RealFaviconGenerator](https://realfavicongenerator.net/)
- [Favicon.io](https://favicon.io/)
