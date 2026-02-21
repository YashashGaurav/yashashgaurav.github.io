# Yashash Gaurav's Personal Website

This is the source code for my personal website, built with [Hugo](https://gohugo.io/) and the [PaperModX](https://github.com/reorx/hugo-PaperModX) theme.

## 🚀 Quick Start

### Prerequisites
- [Hugo](https://gohugo.io/installation/) (extended version)
- [Git](https://git-scm.com/)

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/YashashGaurav/yashashgaurav.github.io.git
cd yashashgaurav.github.io
```

2. Initialize and update the theme submodule:
```bash
git submodule update --init --recursive
```

3. Start the development server:
```bash
hugo server -D
```

4. Open your browser and visit `http://localhost:1313`

### Creating New Content

```bash
# Create a new blog post
hugo new posts/my-new-post.md

# Create a new page
hugo new about.md
```

### Building for Production

```bash
hugo --minify
```

## 📁 Project Structure

```
├── .github/              # GitHub workflows and templates
├── archetypes/           # Content templates
├── assets/               # CSS, JS, and other assets
├── content/              # Website content
│   ├── posts/            # Blog posts
│   └── about.md          # About page
├── static/               # Static files (images, favicon, etc.)
├── themes/               # Hugo themes
│   └── PaperModX/        # PaperModX theme (submodule)
├── hugo.yaml             # Hugo configuration
└── README.md             # This file
```

## 🎨 Customization

- **Theme customization**: Edit `assets/css/extended/custom.css`
- **Site configuration**: Edit `hugo.yaml`
- **Content**: Add/edit files in the `content/` directory

## 🚀 Deployment

This site is automatically deployed to GitHub Pages using GitHub Actions. The workflow is defined in `.github/workflows/hugo.yaml`.

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Contact

- **GitHub**: [@YashashGaurav](https://github.com/YashashGaurav)
- **LinkedIn**: [yashashgaurav](https://linkedin.com/in/yashashgaurav)
- **Twitter**: [@yashashgaurav](https://twitter.com/yashashgaurav)

---

Built with ❤️ using [Hugo](https://gohugo.io/) and [PaperModX](https://github.com/reorx/hugo-PaperModX)
