# MovieDB25

Simple SwiftUI client for The Movie Database (TMDB) built with a lightweight modular architecture (App router + feature modules + shared Core/Data/Domain layers).

## Architecture
- **App layer**: `MovieDB25App` hosts a `NavigationStack` driven by `AppRouter`/`AppRoute` for type-safe navigation.
- **Feature modules** (`Features/*`): Each screen is composed via a small builder that wires **Interactor** (network calls), **Router** (navigation actions), **Presenter** (state machine, async/await + `@Published`), and **View** (SwiftUI). This keeps UI logic separate from data fetching and navigation.
- **Domain**: Shared models such as `Movie` and `PagedResponse`.
- **Data**: Endpoint definitions (`TMDBEndpoint`) describing TMDB paths and query items.
- **Core**: Shared utilities:
  - `APIClient` + `EndPoint` + `APIError` for network requests/decoding with snake_case conversion.
  - `APIConfig` for base URLs and API key lookup from `Info.plist` (`TMDB_API_KEY`).
  - `ImageURL` helper to build poster URLs.

## App Flow
1. **Launch**: `MovieDB25App` builds `MovieListModule` inside a `NavigationStack`.
2. **Discover list**: `MovieListPresenter.onAppear()` fetches `/discover/movie` (paged). The view shows loading, then a list with search filter and incremental load when the user scrolls to the last item.
3. **Navigate to detail**: Tapping a movie calls `MovieListRouter` → `AppRouter.push(.movieDetail(id,title))`.
4. **Detail screen**: `MovieDetailPresenter` fetches `/movie/{id}`, renders poster/title/release/vote/overview, and supports retry/back (`AppRouter.pop()`).

## Setup
1. Obtain a TMDB **API Key (v3 auth)** from TMDB settings.
2. Add it to `Info.plist` under key `TMDB_API_KEY` (no quotes/escaping needed). Example: `c931bd430f....`.
3. Open the project in Xcode and run on iOS 17+ simulator/device.

Notes: Network errors bubble up as `APIError` and are surfaced in the UI. Images are loaded via `AsyncImage` using TMDB’s image base URL.
