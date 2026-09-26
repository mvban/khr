# Khaar Sunnyvale — Flutter App Concept & Architecture

**Not another restaurant app. A journey into Northeast India, one dish at a time.**

---

## 1. The Core Idea

Most restaurant apps are digital menus with a "Order Now" button. Khaar deserves better.

This app is built around a single belief: **Northeast Indian cuisine is unknown to most people, and the best way to fall in love with it is to discover it gradually.** So instead of dumping the whole menu on a user, the app treats every dish, ingredient, and region as something to be *unlocked* — through trying dishes, reading stories, and exploring the Seven Sisters.

The app has three jobs:

1. **Tell the Khaar story** — Nandana's journey, the meaning of *khaar*, why ingredients matter more than spice.
2. **Guide discovery** — a regional passport that fills in as guests try dishes from each state.
3. **Do the practical things effortlessly** — reservations, ordering, catering, events, favourites.

Everything else — menu, bar, chef's specials — is content inside that framework.

---

## 2. Business Details & Links

| Field | Detail |
|---|---|
| **Name** | Khaar Sunnyvale |
| **Address** | 193–195 S Murphy Ave, Sunnyvale, CA 94086 |
| **Cuisine** | Northeast Indian (Assam + Seven Sisters) |
| **Chef / Founder** | Nandana Hazarika |
| **Co-founder** | Biswajit Lahon |
| **Grand Opening** | September 12, 2026 |
| **Capacity** | 135 indoor + outdoor |
| **Philosophy** | Ingredients over heavy spices; GF/DF emphasis |
| **Signature Dishes** | Khaar croquette ($18), Bamboo Blaze, Black Sesame Heritage ($29), Golden Blossom ($32) |
| **Desserts** | Mango tapioca, black sesame cheesecake, Assam tea crème brûlée ($7.49–$13) |
| **Bar** | Mocktails $11, cocktails $15, wine $10–$76, draft beer |
| **Website** | https://khaarsunnyvale.com |
| **Reservation** | https://toast.app/r/posola-193-195-s-murphy-avenue |
| **Instagram** | @khaarsunnyvale |

### Link Reference

| Purpose | Link |
|---|---|
| Reservation (Toast) | `https://toast.app/r/posola-193-195-s-murphy-avenue` |
| Toast App — Play Store | `market://details?id=com.toasttab.consumer` |
| Toast App — Web Play Store | `https://play.google.com/store/apps/details?id=com.toasttab.consumer` |
| Phone | `tel:+14085550100` |
| Directions | `https://www.google.com/maps/search/Khaar+Sunnyvale,193+S+Murphy+Ave,Sunnyvale,CA+94086` |
| Catering inquiry | `mailto:hello@khaarsunnyvale.com` |
| Events | `https://khaarsunnyvale.com/events` |
| Website | `https://khaarsunnyvale.com` |

---

## 3. Splash Screen

**Goal:** no white flash, instant perceived launch, Northeast Indian vibe.

| Element | Detail |
|---|---|
| Background | Terracotta `#B84A2E` |
| Centre | Khaar wordmark / banana-leaf motif |
| Tagline | *"Northeast Indian. No shortcuts."* |
| Duration | ~1.2 s |

**Sequence:** native splash renders instantly (static, OS-level) → Flutter logo scales 0.9→1.0 in 400 ms → tagline fades in → route to Home.

**Packages:** `flutter_native_splash`, `flutter_animate`, `google_fonts`, `go_router`.

---

## 4. The Discovery Journey (The Heart of the App)

This is what makes it not-generic. The app is structured as a **map of Northeast India** — eight states, each with dishes, ingredients, and stories. Users explore at their own pace.

### 4.1 The Regional Passport

A visual map of the Seven Sisters + Assam. Each state starts greyed out.

- **Try a dish from a state** → the state lights up, and a short story about that region unlocks.
- **Try three dishes from a state** → a chef's note from Nandana unlocks (audio or text).
- **Complete all eight states** → a "Khaar Explorer" badge and an invite to a tasting event.

The passport lives on the home screen as the primary navigation. Tapping a state opens its dishes, ingredients, and stories.

### 4.2 Ingredient Encyclopedia

Every dish links to its ingredients. Ingredients are cards that unlock the first time a user encounters them:

- **Khaar** — the alkaline extract from dried banana ash that gives the restaurant its name.
- **Fermented bamboo shoot** (*khorisa*) — used in Bamboo Blaze.
- **Black sesame** (*til*) — the backbone of the Black Sesame Heritage dish.
- **Mustard oil** — the cooking fat of Assam, pungent and essential.
- **Bhoot jolokia** — the ghost chilli. Only unlocks after a user tries a spicy dish.

Each ingredient card has: a photo, a short story, which dishes use it, and a "did you know" line. This turns the menu into a learning experience.

### 4.3 Chef's Voice

Nandana's story is threaded through the app, not buried in an About page.

- **Dish stories** — 30–60 second text or audio notes about why each dish exists.
- **Chef's specials** — updated weekly, with a short note from the kitchen.
- **The Khaar story** — an illustrated, scrollable narrative: her software engineering career, culinary school, the road trip through Assam that inspired the restaurant.

### 4.4 Taste Profile

As users favourite dishes, the app builds a quiet, private taste profile:

- Preferred spice level
- Favourite regions
- Dishes they keep coming back to

Used only to recommend new dishes ("You loved the Bamboo Blaze — try the Khaar Croquette, also from Assam") — never shared, never sold.

---

## 5. Feature Modules

### 5.1 Home

- **Passport map** (primary navigation)
- **Today's special** — chef's pick with a short note
- **Reserve a table** — prominent Toast button
- **Latest story** — rotating dish or ingredient story

### 5.2 Menu

- Filter by region, dietary tag (GF, DF, V, VG), spice level
- Dish cards show the region badge (colour-coded)
- Tapping a dish opens its story, ingredients, and pairing suggestions
- **Favourite** button on every dish

### 5.3 Bar & Beverages

- Cocktails (smoked Assam old fashioned, chai martini)
- Mocktails
- California wine list, filterable
- Draft beer
- Each drink paired with a dish suggestion

### 5.4 Reservations (Toast Deep-Link)

Exactly as specified:
User taps "Reserve a Table"
│
▼
launchUrl("https://toast.app/r/posola-193-195-s-murphy-avenue",
mode: externalApplication)
│
┌────┴────┐
│ │
SUCCESS FAILURE
│ │
Done Show dialog:
┌─────────────────────────────────┐
│ Toast App is not installed │
│ │
│ [Install from Google Play] │
│ [Open in Browser] │
└─────────────────────────────────┘


Play Store link tries `market://details?id=com.toasttab.consumer` first, falls back to the web Play Store URL. Browser option opens the same Toast reservation link in the default browser.

### 5.5 Ordering

- Direct ordering link to the restaurant's Toast POS web ordering page
- Cart is managed by Toast — the app simply deep-links with the items pre-filled where the Toast API allows
- Saved favourites can be re-ordered in two taps

### 5.6 Favourites

- Every dish, drink, and ingredient can be favourited
- Favourites are stored locally (SharedPreferences / Hive) — no login required
- Optional cloud sync via Firebase Auth if the user wants it
- Favourites feed the Taste Profile and recommendations

### 5.7 Catering

- Inquiry form with event type, headcount, date, dietary needs
- Pre-built catering menus (Vegetarian, Signature, Full Journey)
- Submits via email or a backend endpoint; confirmation sent to the user

### 5.8 Events

- Calendar of upcoming events: tasting dinners, regional nights, chef's table
- Each event has a detail page with menu preview and a reserve button (Toast link)
- Past events archived with photos and stories

### 5.9 Story

- The full Khaar narrative, illustrated
- Chef's journey, philosophy, and the meaning of *khaar*
- Behind-the-scenes photos from the kitchen and sourcing trips

### 5.10 Contact & Info

- Address, hours, phone
- Directions via Google Maps
- Instagram feed
- Newsletter signup

---

## 6. Architecture

### 6.1 Project Structure
lib/
├── main.dart
├── app/
│ ├── theme/ # colours, text styles, theme
│ ├── routes/ # GoRouter config
│ └── constants/ # strings, external links
├── models/
│ ├── dish.dart
│ ├── ingredient.dart
│ ├── region.dart
│ ├── event.dart
│ ├── cocktail.dart
│ └── story.dart
├── providers/
│ ├── passport_provider.dart # regional progress
│ ├── favourites_provider.dart
│ ├── menu_provider.dart
│ ├── events_provider.dart
│ └── taste_profile_provider.dart
├── screens/
│ ├── splash/
│ ├── home/
│ ├── passport/ # regional map + state detail
│ ├── menu/
│ ├── dish_detail/
│ ├── ingredient_detail/
│ ├── bar/
│ ├── reservations/
│ ├── catering/
│ ├── events/
│ ├── story/
│ └── contact/
├── widgets/
│ ├── dish_card.dart
│ ├── region_badge.dart
│ ├── ingredient_chip.dart
│ ├── passport_map.dart
│ └── reserve_button.dart
└── services/
├── url_launcher_service.dart
├── toast_reservation_service.dart
├── storage_service.dart # SharedPreferences / Hive
└── notification_service.dart # optional: event reminders


### 6.2 Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter |
| State | Riverpod (or Provider) |
| Navigation | GoRouter |
| Local storage | Hive (favourites, passport progress, taste profile) |
| Backend | Firebase Firestore (menu, events, stories) + Firebase Auth (optional) |
| Deep links | `url_launcher`, `app_links` |
| Animations | `flutter_animate`, `lottie` (for map reveal) |
| Fonts | `google_fonts` (Playfair Display + Lato) |
| Splash | `flutter_native_splash` |
| Notifications | `flutter_local_notifications` (event reminders) |

### 6.3 Data Model (simplified)
Region
id, name, state, story, unlockedAt
├── dishes[]
└── ingredients[]

Dish
id, name, price, regionId, story, spiceLevel,
dietaryTags[], ingredients[], pairingSuggestion

Ingredient
id, name, story, photo, usedInDishes[]

Event
id, title, date, description, menuPreview, toastUrl

UserProgress (local)
visitedStates{}, triedDishes{}, unlockedIngredients{},
favourites[]


### 6.4 Design Principles

- **Warm & earthy** — terracotta, banana-leaf green, turmeric gold
- **Story-first** — every screen tells a piece of the Khaar story
- **No sign-up wall** — browse, favourite, and explore without an account
- **Progressive** — content unlocks as users engage, never overwhelms
- **Fast** — native splash, Google Fonts, lazy-loaded map

---

## 7. Launch Plan (Post-MVP)

1. **MVP** — splash, home, passport, menu, dish detail, reservations
2. **v1.1** — favourites, ingredients, bar
3. **v1.2** — events, catering, chef's specials
4. **v1.3** — taste profile, recommendations, notifications
5. **v2.0** — optional accounts, cloud sync, loyalty

---

## 8. Assets Checklist

| Asset | Source | Destination |
|---|---|---|
| App icon | Khaar brand mark | `assets/icons/app_icon.png` (1024×1024) |
| Dish photos | Professional shoot + Instagram | `assets/images/dishes/` |
| Ingredient photos | Shoot + stock | `assets/images/ingredients/` |
| Map illustration | Custom (Seven Sisters + Assam) | `assets/images/map.png` |
| Chef audio notes | Recorded with Nandana | `assets/audio/` |
| Lottie animations | Map reveal, badge unlock | `assets/lottie/` |

---

## 9. Summary

This is not a menu with a "Reserve" button. It's a **living guide to Northeast Indian cuisine**, built around a regional passport that rewards curiosity. Users start with one dish, read its story, unlock an ingredient, light up a state on the map — and gradually discover the whole cuisine. Reservations, ordering, catering, and events are woven in as natural next steps, not the primary purpose.

The Toast deep-linking is precise: open the app if installed, otherwise show the two-option dialog. The splash screen is optimised for a sub-second perceived launch. Everything else exists to tell the Khaar story — one dish, one ingredient, one state at a time.