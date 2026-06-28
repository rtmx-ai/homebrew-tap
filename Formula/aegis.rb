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
      sha256 "b0349ca414844bd27120357683f47587127c1a310e30e00bd4ebcc0436ee0779"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-amd64.tar.gz"
      sha256 "0deebe2086251a33336dca7e9e8d861b80d386f833cc3784271ddb60e63de67b"
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
