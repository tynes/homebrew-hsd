require "language/node"

class HsClient < Formula
  desc "REST, websocket, and RPC client for hsd"
  homepage "https://handshake.org"
  url "https://github.com/handshake-org/hs-client/archive/v0.0.8.tar.gz"
  sha256 "9702f863ff7b52800edd3cba03d6302b2338bbff53dc644dcab23709078b4123"

  depends_on "node@10"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/hsd-cli", "--version"
  end
end
