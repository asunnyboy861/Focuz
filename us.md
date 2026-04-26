# Focuz - iOS App Development Guide

## Executive Summary

**Focuz** is an ADHD-first visual habit tracker that replaces punishment with compassion. Unlike traditional habit trackers that use streaks (which reset to zero on a single miss, devastating ADHD users), Focuz introduces an elastic scoring system where missing one day only slightly reduces your consistency score from 96% to 94% - never to zero.

**Core Differentiators**:
1. **Zero-Punishment System**: Elastic scoring algorithm (inspired by Loop/uHabits) replaces streaks with consistency percentages
2. **Time Visualization**: Color-coded time flow bars and heatmaps help time-blind users see time passing
3. **Flexible Frequency**: Support for X-per-week, X-per-month patterns - not forced daily
4. **One-Time Purchase**: $9.99 lifetime unlock - no subscription fatigue for ADHD users
5. **Compassionate Design**: No red colors, no "failure" language, gentle weekly resets

**Target Market**: ADHD adults (18-45) in the US who have abandoned traditional habit trackers due to streak anxiety, cognitive overload, or subscription fatigue.

**App Name**: Focuz
**Subtitle**: See Your Time, Shape Your Habits
**Bundle ID**: com.zzoutuo.Focuz
**Minimum iOS**: 17.0

## Competitive Analysis

| Competitor | Rating | Price | ADHD Fit | Key Weakness | Focuz Advantage |
|-----------|--------|-------|----------|-------------|-----------------|
| **Streaks** | 4.8/5 | $5.99 one-time | Low | Streak reset = devastating; forced daily; max 12 habits | Elastic scoring never resets; flexible frequency; unlimited habits |
| **Tiimo** | 4.5/5 | Free + $7/mo | High | Expensive subscription; limited free tier | One-time $9.99; no subscription anxiety |
| **Finch** | 4.9/5 | Free + IAP | Medium | Pet care distracts from habits; no time visualization | Focused on habits; time flow visualization |
| **Habitica** | 4.4/5 | Free + IAP | Medium | RPG adds cognitive load; messy navigation | Minimal cognitive load; visual-first design |
| **(Not Boring) Habits** | 4.7/5 | $14.99 one-time | Medium | Confusing navigation; no calendar view; 3D distraction | Clean navigation; heatmap view; focused UI |
| **Loop/uHabits** | 4.3/5 | Free open-source | Medium | Android only; outdated UI; no widgets | Native iOS; modern SwiftUI; full widget support |

**Market Gap**: No iOS habit tracker combines elastic scoring + time visualization + ADHD-friendly design + one-time pricing. Focuz fills this gap.

## Technical Architecture

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| UI Framework | SwiftUI + @Observable | Native performance, declarative UI, fluid animations |
| Architecture | MVVM + Service Layer | Proven pattern from TeymiaHabit reference project |
| Local Storage | SwiftData | Apple native ORM, auto-migration, optional iCloud sync |
| Cloud Sync | CloudKit (optional) | Free, native integration, user-controlled toggle |
| Time Visualization | SwiftUI Canvas + TimelineView | Custom drawing for time bars, heatmaps, glow effects |
| Habit Timer | ActivityKit + Live Activity | Lock screen / Dynamic Island real-time display |
| Widgets | WidgetKit | Home screen + lock screen one-tap check-in |
| Animations | PhaseAnimator + Canvas | Satisfaction particle effects, biological mirroring |
| Notifications | UNUserNotificationCenter | Smart escalating reminders |
| Haptics | UIImpactFeedbackGenerator | Completion tactile feedback |
| Data Export | CoreGraphics PDF | CSV/JSON/PDF export |
| IAP | StoreKit 2 | Non-consumable one-time purchase |

## Module Structure & File Organization

```
Focuz/
├── FocuzApp.swift                    # App entry point
├── Models/
│   ├── Habit.swift                   # SwiftData habit model
│   ├── HabitCompletion.swift         # Completion record model
│   ├── TimerSession.swift            # Timer session model
│   ├── HabitFrequencyData.swift      # Frequency serialization wrapper
│   └── HabitFrequency.swift          # Frequency enum
├── Engines/
│   └── HabitScoreEngine.swift        # Elastic scoring algorithm
├── Services/
│   ├── HabitService.swift            # Core business logic
│   ├── TimerService.swift            # Timer management
│   ├── NotificationService.swift     # Smart reminders
│   └── PurchaseManager.swift         # StoreKit 2 IAP
├── ViewModels/
│   ├── TodayViewModel.swift          # Today screen logic
│   ├── InsightsViewModel.swift       # Insights screen logic
│   ├── BuildViewModel.swift          # Habit builder logic
│   └── SettingsViewModel.swift       # Settings logic
├── Views/
│   ├── ContentView.swift             # Main tab navigation
│   ├── TodayView.swift               # Today screen
│   ├── InsightsView.swift            # Insights/statistics
│   ├── BuildView.swift               # Habit builder
│   ├── SettingsView.swift            # Settings
│   ├── HabitDetailView.swift         # Single habit detail
│   ├── HeatmapView.swift             # 90-day heatmap
│   ├── TimeFlowBar.swift             # Time visualization bar
│   ├── HabitCircleView.swift         # Visual habit circle
│   ├── GentleResetView.swift         # Weekly gentle reset
│   ├── PaywallView.swift             # Pro upgrade screen
│   └── ContactSupportView.swift      # Feedback form
├── Components/
│   ├── ElasticScoreRing.swift        # Animated score ring
│   ├── CompletionParticleEffect.swift # Satisfaction particles
│   └── BreathingAnimation.swift      # Biological mirroring pulse
├── Extensions/
│   ├── Color+Hex.swift               # Hex color support
│   ├── Date+Extensions.swift         # Date helpers
│   └── View+Extensions.swift         # View modifiers
└── Resources/
    └── Assets.xcassets/              # App icons, colors
```

## Implementation Flow

### Step 1: Data Models & Scoring Engine
- Create SwiftData models (Habit, HabitCompletion, TimerSession, HabitFrequencyData)
- Implement HabitFrequency enum with all frequency types
- Implement HabitScoreEngine with elastic scoring algorithm
- Verify models compile and relationships are correct

### Step 2: Core Services
- Implement HabitService (CRUD operations, completion tracking)
- Implement TimerService (start/stop/pause timer sessions)
- Implement NotificationService (schedule/cancel reminders)
- Implement PurchaseManager (StoreKit 2 non-consumable)

### Step 3: Main Navigation & Today Screen
- Create ContentView with TabView (Today, Insights, Build, Settings)
- Create TodayView with time flow bar, habit circles, mini heatmap
- Create HabitCircleView with elastic score display
- Create TimeFlowBar with TimelineView + Canvas

### Step 4: Habit Builder & Detail
- Create BuildView for adding/editing habits
- Create HabitDetailView with full heatmap, score ring, timer
- Create HeatmapView (90-day contribution graph)
- Create ElasticScoreRing (animated progress ring)

### Step 5: Insights & Statistics
- Create InsightsView with weekly/monthly trends
- Show elastic score trends, best days, consistency metrics
- Gentle weekly reset prompt

### Step 6: Settings & IAP
- Create SettingsView with preferences, iCloud toggle, about
- Create PaywallView with one-time $9.99 purchase
- Create ContactSupportView with feedback form
- Integrate policy page links

### Step 7: Animations & Polish
- Implement CompletionParticleEffect
- Implement BreathingAnimation for waiting states
- Add haptic feedback on completion
- Add spring animations throughout

### Step 8: Dark Mode & Accessibility
- Full dark mode support with Sage/Amber color adaptation
- VoiceOver labels for all interactive elements
- Dynamic Type support

## UI/UX Design Specifications

### Design System: "Calm Glow"

| Dimension | Specification | ADHD Rationale |
|-----------|--------------|----------------|
| Primary Color | Sage Green #8CB369 + Warm Amber #F4A261 | Green = growth; Amber = warmth; NO red = no punishment |
| Background | Cream #FFF8F0 + Liquid Glass | Warm, not harsh; glass reduces visual load |
| Corner Radius | 20-28pt super-rounded | Friendly, non-threatening, reduces anxiety |
| Font | SF Pro Rounded (system) | Rounded = less serious; ADHD-friendly |
| Icons | SF Symbols + Emoji | Emoji more intuitive than abstract icons |
| Animation | Spring + breathing rhythm | Biological mirroring (Drift principle) |
| Dark Mode | Full support, free | 60%+ US users prefer dark mode |
| Forbidden | No red, no streak numbers, no "fail" text | Zero-punishment design core |

### Tab Structure
- **Today**: Time flow bar + habit circles + mini heatmap
- **Insights**: 90-day heatmap + elastic score trends + weekly stats
- **Build**: Add/edit habits with emoji picker, frequency, color
- **Settings**: Preferences, iCloud, Pro upgrade, support, policies

### Key Screens
1. **Today Screen**: Greeting with elastic score, time flow bar showing remaining day, habit circles with completion dots and elastic percentage, mini weekly heatmap
2. **Habit Detail**: Full 90-day heatmap, elastic score ring with encouraging text, frequency display, timer with time visualization
3. **Gentle Reset**: Weekly summary with "You showed up X% of the time" positive framing, zero-punishment tip
4. **Paywall**: One-time $9.99 purchase, feature comparison, no dark patterns

## Code Generation Rules

1. Single responsibility: One feature per module, high cohesion, low coupling
2. Semantic naming: Clear, descriptive names for all types and functions
3. Code reuse: Merge similar code, Rule of Three abstraction
4. Clean refactoring: Remove deprecated code when replacing
5. Apple native first: Use SwiftUI, SwiftData, StoreKit 2 natively
6. No comments in code unless explicitly requested
7. All SwiftData attributes must be optional or have default values
8. All relationships must have inverse relationships
9. Never hardcode version numbers - read from Bundle
10. Never use .tabViewStyle(.sidebarAdaptable) - causes iPad layout issues
11. For main content in ScrollView, always add .frame(maxWidth: 720).frame(maxWidth: .infinity)
12. Do NOT use ObservableObject conformance on views already marked with @Observable
13. Do NOT use iOS 18+ only APIs when targeting iOS 17+
14. Use Color.accentColor instead of ShapeStyle.accent

## Testing & Validation Standards

- Build must succeed on both iPhone and iPad simulators
- Test on iPhone XS Max (primary phone)
- Test on iPad Pro 13-inch M4 (primary tablet)
- Verify no narrow sidebar issues on iPad
- Verify dark mode renders correctly
- Verify elastic scoring produces correct results
- Verify IAP flow works with StoreKit configuration
- Verify widgets compile correctly
- Clean build folder between test runs

## Build & Deployment Checklist

1. Verify Bundle ID: com.zzoutuo.Focuz
2. Verify iOS Deployment Target: 17.0
3. Verify Marketing Version: 1.0.0
4. Verify Current Project Version: 1
5. App icon configured in Assets.xcassets
6. StoreKit configuration file for local testing
7. Privacy descriptions for notifications
8. Build succeeds on iPhone simulator
9. Build succeeds on iPad simulator
10. All required documents generated (us.md, capabilities.md, icon.md, price.md, nowgit.md, keytext.md)
11. Screenshots captured for App Store
12. Push to GitHub repository
