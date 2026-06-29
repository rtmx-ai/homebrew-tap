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
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-darwin-arm64.tar.gz"
      sha256 "9a03afaa0f957b748d51e6211f76bccb7ce17e524232bbe41664f3e311304b1a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-arm64.tar.gz"
      sha256 "d057a2868ea52dc93464ce3d5f4ae93d89fe651bde4e0982165f5dfbedff3495"
    end
    on_intel do
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v#{version}/aegis-#{version}-linux-amd64.tar.gz"
      sha256 "d3b1219fcfd62dbfd5d1bd49b774da682f44d5cfa409b5d4c5dd01c614527d14"
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
