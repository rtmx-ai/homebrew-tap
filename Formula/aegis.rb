class Aegis < Formula
  desc "Terminal-native agentic AI pair programmer for CUI environments"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    # ARM binary runs natively on Apple Silicon and via Rosetta 2 on Intel.
    url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.1/aegis-0.1.1-macos-aarch64.tar.gz"
    sha256 "5ff4b8c2a17a99ae235f733a6ca27e255f406f7772bfa6c77fca39131bd282fb"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.1/aegis-0.1.1-linux-x86_64.tar.gz"
      sha256 "b86553a36d3a2051d88ce8fe69928a9e219523f6c268b77c6ee0a955c8a8fe29"
    elsif Hardware::CPU.arm?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.1.1/aegis-0.1.1-linux-aarch64.tar.gz"
      sha256 "83710dc8d65087f619f07868a91e0034fac81aa8228da9e4a5218f3947bd5910"
    end
  end

  def install
    bin.install "aegis"
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis --version")
  end
end
