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
| Landing Page | https://asunnyboy861.github.io/Focuz-pages/ | ✅ **LIVE** |
| Support | https://asunnyboy861.github.io/Focuz-pages/support.html | ✅ **LIVE** |
| Privacy Policy | https://asunnyboy861.github.io/Focuz-pages/privacy.html | ✅ **LIVE** |
| Terms of Use | https://asunnyboy861.github.io/Focuz-pages/terms.html | ✅ **LIVE** |

## Screenshots

### iPhone Screenshots (1242×2688)
| File | Screen | Status |
|------|--------|--------|
| iphone_01_today.png | Today View | ✅ Generated |
| iphone_02_insights.png | Insights View | ✅ Generated |
| iphone_03_build.png | Habit Builder | ✅ Generated |
| iphone_03_today_habits.png | Today with Habits | ✅ Generated |
| iphone_04_settings.png | Settings | ✅ Generated |

### iPad Screenshots (2064×2752)
| File | Screen | Status |
|------|--------|--------|
| ipad_01_today.png | Today View | ✅ Generated |
| ipad_02_insights.png | Insights View | ✅ Generated |
| ipad_03_build.png | Habit Builder | ✅ Generated |
| ipad_04_settings.png | Settings | ✅ Generated |

## Deployment Checklist

- [x] Generate iPhone screenshots (5)
- [x] Generate iPad screenshots (4)
- [x] Create App Store metadata (keytext.md)
- [x] Create price configuration (price.md)
- [x] Create capabilities guide (capabilities.md)
- [x] Create icon configuration (icon.md)
- [x] Create policy pages (Focuz-pages/)
- [x] Initialize main app git repository
- [x] Create GitHub repository: asunnyboy861/Focuz
- [x] Push main app code to GitHub
- [x] Create GitHub repository: asunnyboy861/Focuz-pages
- [x] Push policy pages to GitHub
- [x] Enable GitHub Pages on Focuz-pages repository
- [ ] Submit to App Store Connect

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
