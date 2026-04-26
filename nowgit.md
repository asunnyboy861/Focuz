# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | Focuz |
| **Git URL** | git@github.com:asunnyboy861/Focuz.git |
| **Repo URL** | https://github.com/asunnyboy861/Focuz |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ❌ **DISABLED** (iOS app distributed via App Store) |

## Policy Pages (Separate Repository)

| Item | Value |
|------|-------|
| **Repository Name** | Focuz-pages |
| **Git URL** | git@github.com:asunnyboy861/Focuz-pages.git |
| **Repo URL** | https://github.com/asunnyboy861/Focuz-pages |
| **Visibility** | Public |
| **GitHub Pages** | ✅ **ENABLED** |

### Deployed Pages

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/Focuz-pages/ | ⏳ Pending |
| Support | https://asunnyboy861.github.io/Focuz-pages/support.html | ⏳ Pending |
| Privacy Policy | https://asunnyboy861.github.io/Focuz-pages/privacy.html | ⏳ Pending |
| Terms of Use | https://asunnyboy861.github.io/Focuz-pages/terms.html | ⏳ Pending |

## Repository Structure

### Main App Repository
```
Focuz/
├── Focuz/                         # iOS App Source Code
│   ├── Focuz.xcodeproj/           # Xcode Project
│   ├── Focuz/                     # Swift Source Files
│   │   ├── Views/
│   │   ├── Models/
│   │   ├── ViewModels/
│   │   ├── Services/
│   │   ├── Engines/
│   │   └── Components/
│   └── Resources/
│       └── Assets.xcassets/
├── Focuz-pages/                   # Policy Pages (separate deployment)
│   ├── index.html
│   ├── support.html
│   ├── privacy.html
│   └── terms.html
├── us.md                          # English Development Guide
├── keytext.md                     # App Store Metadata
├── project.yml                    # XcodeGen Configuration
└── nowgit.md                      # This File
```

### Policy Pages Repository
```
Focuz-pages/
├── index.html                     # Landing Page
├── support.html                   # Support Page
├── privacy.html                   # Privacy Policy
├── terms.html                     # Terms of Use (required for subscription)
├── .github/
│   └── workflows/
│       └── deploy.yml             # GitHub Pages deployment
└── README.md
```

## Notes

- **Main App**: Distributed via Apple App Store, not GitHub Pages
- **Policy Pages**: Deployed to GitHub Pages for public access
- **Terms of Use**: Required for subscription-based apps (IAP)
- **Contact Email**: iocompile67692@gmail.com
