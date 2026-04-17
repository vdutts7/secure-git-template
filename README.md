# secure-git-template

Forge-agnostic private Git repo template with:

- optional `git-crypt` setup for derived repos
- commit-message obfuscation via `.commits.jsonl`
- `pre-commit` metadata stripping
- `pre-push` health and encryption checks
- repo-local identity kept in `.git/config`

## Quickstart

1. Clone or use this template to create a new repo.
2. Set the remote you want.
3. Set repo-local identity with local Git config.
4. If you want tracked-file encryption, run `git-crypt init` in your derived repo.
5. Uncomment the `git-crypt` rule in `.gitattributes`.
6. Export and store your key securely.
7. Commit and push once hooks and encryption are active.

## Notes

- Tracked `./.gitconfig` is for non-sensitive repo policy only.
- Effective identity should live in repo-local `.git/config`.
- Hooks live in `.hooks/`.
- This template repo itself does not require active `git-crypt`.
