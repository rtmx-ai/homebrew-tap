# Homebrew formula for aegis (REL-006/007).
#
# Installs the aegis binary + its bundled harness (OpenCode, ripgrep, config-seed,
# llama-server) into the keg's libexec, and a bin/aegis wrapper that points aegis at that
# libexec (AEGIS_LIBEXEC, REL-005). The model GGUF is side-loaded separately (air-gap) — it
# is far too large for a bottle and must come via the staging flow, not brew.
#
# Tap usage:  brew install rtmx-ai/tap/aegis   (github.com/rtmx-ai/homebrew-tap)
#
# `version`, the per-platform `url`s, and `sha256`s are filled in at release time from the
# dist/aegis-<version>-<os>-<arch>.tar.gz bundle tarballs (scripts/release.sh). This template
# lives in the source repo; REL-007 publishes a filled copy to the tap as Formula/aegis.rb.
class Aegis < Formula
  desc "Air-gap-native agentic coding orchestrator (rtmx intent loop over a local model)"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-darwin-arm64.tar.gz"
      sha256 "ffaca622d683d6fca455903ebb3a8f43504b6c5a70648d840997bcc947fb564d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-arm64.tar.gz"
      sha256 "efbf0a3e17b67fef2269c06ed1f2d40e317e6de097ecbb41bbbc24fea75c1e29"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-amd64.tar.gz"
      sha256 "a7608b580929e35a01179d1cc8de5ebd5bc9380bae392eb3cdff9f9dc2a2e28f"
    end
  end

  def install
    # Co-locate aegis with its helpers in libexec, then expose a bin wrapper that pins
    # AEGIS_LIBEXEC to the keg's libexec so the helpers resolve regardless of how bin/aegis
    # is invoked (REL-005).
    libexec.install "bin/aegis"
    libexec.install Dir["libexec/*"]
    (bin/"aegis").write_env_script libexec/"aegis", AEGIS_LIBEXEC: libexec.to_s
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis version")
  end
end
