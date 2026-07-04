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
  version "1.9.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-darwin-arm64.tar.gz"
      sha256 "a20b14b69a927be57f23063dc029aa020bab91cc4ad8de7981a82b9ad786b570"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-arm64.tar.gz"
      sha256 "381ad888624d9a7476734f63864c07ec16b4e06f3f990fe70087c8b62c584acb"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-amd64.tar.gz"
      sha256 "2e1e36fd16703e40d603f4f295291e228ae4c9fbb272209ffb2c06b4b6e52010"
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
