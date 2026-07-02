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
  version "1.9.0"
  license "Apache-2.0"

  on_macos do
  end
  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-arm64.tar.gz"
      sha256 "eaa52c1413868756aa491dedd11d86667bf859e8ff13c7a9b5f3ecc81c9ff5ad"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-amd64.tar.gz"
      sha256 "7f43ea9c7f517e91dd10c4af922d05616fe43ea1c2d4d4bd6b490dc0f2f6d3ad"
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
