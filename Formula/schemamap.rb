class Schemamap < Formula
  desc "Instant batch data import for Postgres"
  homepage "https://github.com/schemamap/schemamap"
  version "0.4.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.1/schemamap-x86_64-apple-darwin.zip"
      sha256 "9a51fabe1da100c4d3ae33ab17b99fd970422e4d5fa6eb0504d6bacf451cdf95"

      def install
        bin.install "schemamap"
      end
    end

    on_arm do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.1/schemamap-aarch64-apple-darwin.zip"
      sha256 "c95bd1a85b0a670084ecc2077db9bdaecdccfbf7204703d1c8c379980ed36a9a"

      def install
        bin.install "schemamap"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.1/schemamap-x86_64-unknown-linux-gnu.zip"
      sha256 "6939753ed98876296515c3b0df7810a2495b29263ed7f251be820fb111df91a2"

      def install
        bin.install "schemamap"
      end
    end
  end

  service do
    run [opt_bin/"schemamap", "up", "-f", "#{etc}/schemamap/schemamap-tunnel.toml"]
    keep_alive true
    log_path var/"log/schemamap.log"
    error_log_path var/"log/schemamap.log"
  end

  test do
    output = shell_output("#{bin}/schemamap init --dbname=postgres --dry-run")
    assert_match "create schema if not exists schemamap;", output

    assert_match version.to_s, shell_output("#{bin}/schemamap --version")
  end
end
