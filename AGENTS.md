# Project Automation & Build Guidelines

This repository already includes automation for GitHub Actions (see `GITHUB_CI_SETUP.md`) and Codemagic (`codemagic.yaml`). Follow the practices below when updating CI or writing build instructions.

## General Expectations
- Target **Flutter 3.27.4** unless the workflows are updated first.
- Avoid introducing signing credentials into public configs; current pipelines build unsigned artifacts only.
- Keep Android `minSdk` at **23** and ensure Java/Kotlin toolchains target **Java 17**.

## GitHub Actions Notes
- Reuse the existing workflows in `.github/workflows/` when adding jobs—mirror the structure documented in `GITHUB_CI_SETUP.md`.
- Build steps should run `flutter pub get`, optional `build_runner`, then `flutter test`, followed by the platform build commands already listed in the guide.
- When modifying workflows, update `GITHUB_CI_SETUP.md` if behavior changes.

## Codemagic Notes
- Codemagic definitions live in `codemagic.yaml`; keep the iOS, Android, and combined workflows aligned with that file.
- Preserve the namespace/Gradle patch scripts that run before Android builds; update versions only if dependent plugin versions change.
- Ensure artifacts list includes the unsigned APK/AAB or IPA outputs under `build/`.

## Local Build Checklist
Before publishing CI changes, confirm the commands from `GITHUB_CI_SETUP.md` succeed locally:
1. `flutter build apk --release`
2. `flutter build appbundle --release`
3. `flutter build ios --no-codesign`

Document any deviations directly in the relevant workflow and in `GITHUB_CI_SETUP.md`.
