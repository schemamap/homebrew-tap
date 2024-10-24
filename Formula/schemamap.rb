class Schemamap < Formula
  desc "Instant batch data import for Postgres"
  homepage "https://github.com/schemamap/schemamap"
  version "0.4.3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.3/schemamap-x86_64-apple-darwin.zip"
      sha256 "10f8817841a6667a5be9a0ecd0d14b593717308e3b2f4276be4a76b7941a44f2"

      def install
        bin.install "schemamap"
      end
    end

    on_arm do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.3/schemamap-aarch64-apple-darwin.zip"
      sha256 "f9a274545f0071a0343bd2fbe875d4df16f2fc2143ba3154c714f67cad4495cf"

      def install
        bin.install "schemamap"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.3/schemamap-x86_64-unknown-linux-gnu.zip"
      sha256 "2ba9e2c614bef1cb44a206eec6c18953f43e8d8581b92f2f40446929713f300a"

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
