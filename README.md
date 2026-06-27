# rtmx-ai/homebrew-tap

Homebrew tap for [**aegis**](https://github.com/rtmx-ai/aegis-cli) — the air-gap-native
agentic coding orchestrator (rtmx intent loop over a local model).

## Install

```bash
brew install rtmx-ai/tap/aegis
```

This installs the `aegis` binary plus its bundled harness (OpenCode, ripgrep, llama-server)
into the keg's `libexec`, with a `bin/aegis` wrapper that points aegis at them
(`AEGIS_LIBEXEC`). The model GGUF is **side-loaded separately** (air-gap) — it is far too
large for a bottle and must be staged via aegis's model flow, not brew.

## Maintenance

`Formula/aegis.rb` is **auto-published** by the aegis-cli release workflow on every `v*` tag:
it fills the `version` and per-platform `sha256` from the release bundle tarballs
(`aegis-<version>-<os>-<arch>.tar.gz`). **Do not hand-edit it** — changes are overwritten on
the next release. Until the first tagged release fills it, the `sha256` fields are
`REPLACE_*` placeholders and `brew install` will not yet resolve.
