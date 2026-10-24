# Exploration

Start shallow. Go deep only when needed.

First pass:
- top-level directories
- package/manifests
- README/architecture docs
- relevant entry points
- relevant feature area

Avoid broad test reading during planning. Record where tests live; read specific tests only when the task needs them.

Coverage guidance:
- small repo: direct read
- medium: 1–2 focused agents
- large: 2–4 focused agents
- monorepo: only inspect packages relevant to the task

Do not read every file in a folder merely because it exists.
