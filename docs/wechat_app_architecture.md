# AI WeChat App Architecture

This document distils the feature alignment we discussed and maps it onto the
current Flutter project. It acts as the reference before the actual
implementation work.

## High-Level Modules

| Module            | Description                                                                                          |
|-------------------|------------------------------------------------------------------------------------------------------|
| `desktop`         | Existing springboard. Two app icons must launch the rebuilt **WeChat** and **API 设置** experiences. |
| `wechat`          | New multi-tab app (会话 / 通讯录 / 发现 / 我) that wraps AI chat flows, personas and timelines.       |
| `api_settings`    | Multi-endpoint management, persona/world info editing, preset management.                            |
| `data`            | Drift-based persistence for conversations, messages, memories, contacts, presets and endpoint refs.  |
| `services`        | Repository/services layer exposing async APIs to UI (GetX controllers).                              |

## Data Persistence (Drift)

We migrate away from `SpUtil` for any structured data related to chat. Only user
API keys continue to live in secure storage/keychain. Suggested tables:

- `contacts`: AI personas with metadata, greeting, avatar colour, endpoint ref.
- `conversations`: Chat channels with unread counters, last message, endpoint/preset overrides.
- `participants`: Link contacts to conversations (future multi-role support).
- `messages`: Chat history with status, sender, parent id, timestamps, format.
- `generations`: Alternate completions for a message (`variant_index`, scores, params snapshot).
- `memory_entries`: Persona, lorebook, summary and pinned fragments tied to conversations.
- `attachments`: Images/files metadata stored on disk; DB keeps pointer and checksum.
- `model_presets`: Reusable generation parameter bundles.
- `provider_profiles`: API endpoint definitions (id, base_url, default model, type).
- `provider_keys`: Only stores labels and secure storage keys references (no plaintext).
- `messages` keeps a `content_search_terms` column (bi-gram tokens) for `LIKE`-based Chinese search.

### Drift Notes

- Run `build_runner` to generate companions. Store definitions in
  `lib/data/database.dart` and `lib/data/daos/*.dart`.
- Use `moor_ffi` on mobile and `sqlite3_flutter_libs` to bundle native libs.
- Provide migrations (v1 baseline) and seeding logic for default persona/endpoint.

## AI Memory Strategy

- Default: automatic summaries when rolling window exceeds ~2k tokens.
- Conversation-level settings: toggle auto-summary, target window size, target summary length.
- Manual memory management: long-press message → “存入记忆” (pin), “设为常驻” (pin flag).
- Store memory metadata in `memory_entries`, with `type` (persona/lore/summary/pin) and `last_used_at`.
- On each request, compose prompt: global persona → pinned entries → latest summaries → recent messages.

## Search (中文友好)

- On insert/update of messages, generate字符 bi-gram tokens and store them in `messages.content_search_terms`.
- Query pipeline: tokenize the query the same way, apply chained `LIKE` filters, fallback to fuzzy matching for single characters.
- Results ordered by recency with basic weighting; highlighting can be layered later if needed.

## API Settings App

- Sections remain: 接口 / 个性 / 世界信息.
- New capabilities:
  - Multiple endpoints stored in Drift (`provider_profiles`).
  - API keys saved with `flutter_secure_storage`; DB keeps `secure_ref`.
  - Mark one endpoint as “当前使用”; conversation overrides still possible.
  - Batch import/export (JSON) sans secrets.
  - Connectivity test (HEAD/chat completions) with delimited logging.

## WeChat App UI

- Bottom navigation replicates 微信结构.
  - 会话：Pulls from `conversations` DAO, shows unread, pinned, search entry.
  - 通讯录：Displays personas (with filters, import/export). Tapping opens detail + chat now.
  - 发现：Local Moments feed. Each post optionally references a conversation/message snapshot.
  - 我：Profile, theme, memory defaults, import/export, diagnostics (SillyTavern-style).
- Chat detail page:
  - Bubble layout matching WeChat.
  - Streaming responses, stop/retry, regenerate variants with comparison sheet.
  - Long-press actions: copy, edit & resend, favourite, memory, delete.
  - Inline status chips (sending/failed) and tool buttons (“+” grid for media, card share, etc.).
  - Header quick toggles: model selection, endpoint info, memory settings.

## Desktop Integration

- `desktop_logic.onAppTap`:
  - `"WeChat"` → `AppNavigator.startWeChat()` (route to new module).
  - `"API 设置"` → `AppNavigator.startApiSettings()`.
- Update icons/labels only if necessary; ensure consistent theming between apps.

## Migration Plan

1. Introduce Drift and secure storage helpers (generate DB).
2. Build repositories bridging Drift tables and existing services; migrate `ApiSettingsService`.
3. Replace `WeChatMock` with tab scaffold using new controllers.
4. Implement chat page hooking to new repositories + API clients.
5. Layer search & memory features; wire Discover/Mine placeholders.
6. Provide data import/export utilities (JSON + attachments).

This document should stay in sync with the implementation; update it if schema or
behaviour changes.
