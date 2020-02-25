require "language/node"

class Hsd < Formula
  desc "Handshake Daemon & Full Node"
  homepage "https://handshake.org"
  url "https://github.com/handshake-org/hsd/archive/v2.0.2.tar.gz"
  sha256 "6a519a6093481b60c04944528ff28752ccac00694c3e47635fa941d42bb7970b"

  depends_on "node@10"
  depends_on "python" => "build"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/hsd", "--version"
  end
end
