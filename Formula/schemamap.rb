class Schemamap < Formula
  desc "Instant batch data import for Postgres"
  homepage "https://github.com/schemamap/schemamap"
  version "0.3.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.3.0/schemamap-x86_64-apple-darwin.zip"
      sha256 "533de7375c6e4f2c8e43b7841df8518ff3e362aa61e09ed45bf6265b95b81e70"

      def install
        bin.install "schemamap"
      end
    end

    on_arm do
      url "https://github.com/schemamap/schemamap/releases/download/v0.3.0/schemamap-aarch64-apple-darwin.zip"
      sha256 "8ee2b6b88240f73a0569a0c1687b80ccb0f6f45caed4cb1b631012004063ab25"

      def install
        bin.install "schemamap"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/schemamap/schemamap/releases/download/v0.3.0/schemamap-x86_64-unknown-linux-gnu.zip"
      sha256 "c62e00b6fc6f504494e201e9ecfadd5769608cf86d71787ece0fa8a50172b709"

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
