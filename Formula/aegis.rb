class Aegis < Formula
  desc "Terminal-native agentic AI pair programmer for CUI environments"
  homepage "https://github.com/rtmx-ai/aegis-cli"
  version "0.0.1-alpha"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/rtmx-ai/aegis-cli/releases/download/v0.0.1-alpha/aegis-0.0.1-alpha-x86_64-apple-darwin.tar.gz"
      sha256 "9d1eb1217c599859d4496708622827dd14160e1a866ce8dc47813ba247c1bb9d"
    end
  end

  def install
    bin.install "aegis"
  end

  test do
    assert_match "aegis", shell_output("#{bin}/aegis --version")
  end
end
