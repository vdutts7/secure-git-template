<div align="center">

<h1>private-git-template</h1>
<p><i><b>opinionated private-repo bootstrap with one command setup</b></i></p>

[![GitHub][github]][github-url]
[![Homebrew][homebrew]][homebrew-url]

</div>

## Table Of Contents

- [About](#about)
- [Install](#install)
- [Usage](#usage)
- [Requirements](#requirements)
- [Contact](#contact)

___

## About

- **problem** - private repos drift into inconsistent local setup and weak guardrails
- **solution** - force one install path and one setup command with hooks + identity + encryption
- **summary** - clone, run command, store key, commit, push

___

## Install

```bash
brew tap vdutts7/tap && brew install shelllock git-crypt git-lfs && git lfs install && \
git clone <your-repo-url> && cd <your-repo-dir> && \
./.hooks/scripts/setup.sh --remote "<your-remote-url>" --name "<git-name>" --email "<git-email>" --pseudo-encrypt-commits --git-crypt --key-output "$HOME/Downloads/git-crypt-key" && \
open "$HOME/Downloads" && rm "$HOME/Downloads/git-crypt-key" && \
git add . && git commit -m "initial setup" && git push -u origin main
```

___

## Usage

```bash
.hooks/scripts/setup.sh --remote "<your-remote-url>" --name "<git-name>" --email "<git-email>" --pseudo-encrypt-commits --git-crypt --key-output "$HOME/Downloads/git-crypt-key"
```

| Arg | Purpose |
|---|---|
| `--remote` | set or replace `origin` |
| `--name` | set repo-local `user.name` in `.git/config` |
| `--email` | set repo-local `user.email` in `.git/config` |
| `--pseudo-encrypt-commits` | obfuscate commit messages as `..` and log originals to `.commits.jsonl` |
| `--git-crypt` | initialize `git-crypt` and activate `.gitattributes` encryption rule |
| `--key-output` | export git-crypt key file |

Examples:

```bash
# full setup
./.hooks/scripts/setup.sh --remote "git@github.com:owner/repo.git" --name "your-name" --email "your-email@example.com" --pseudo-encrypt-commits --git-crypt --key-output "$HOME/Downloads/git-crypt-key"

# first push
git add . && git commit -m "initial setup" && git push -u origin main
```

___

## Requirements

- `git`
- `bash`
- `python3`
- `shelllock`
- `git-crypt`
- `git-lfs`

___

## Contact

- **repo** - [private-git-template][github-url]
- **issues** - [open an issue](https://github.com/vdutts7/private-git-template/issues)

[github]: https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white
[github-url]: https://github.com/vdutts7/private-git-template
[homebrew]: https://img.shields.io/badge/Homebrew-FBB040?style=for-the-badge&logo=homebrew&logoColor=black
[homebrew-url]: https://github.com/vdutts7/homebrew-tap
