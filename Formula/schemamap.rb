class Schemamap < Formula
  desc "Instant batch data import for Postgres"
  homepage "https://github.com/schemamap/schemamap"
  version "0.4.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.2/schemamap-x86_64-apple-darwin.zip"
      sha256 "341130f33afdbff0a471e76722270248ed1f9044000cc69d832f6ca7824b1f62"

      def install
        bin.install "schemamap"
      end
    end

    on_arm do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.2/schemamap-aarch64-apple-darwin.zip"
      sha256 "c8eedd69cfe6b3ec09edc239f06481c9cb9b5a502e742fa89da85f0387e0e07a"

      def install
        bin.install "schemamap"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.4.2/schemamap-x86_64-unknown-linux-gnu.zip"
      sha256 "823f939708ca5234ebe433da119e38c2db1e006a9cf1f2cd994dbcf5c9ab7ca5"

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
