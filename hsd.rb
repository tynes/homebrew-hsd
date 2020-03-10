require "language/node"

class Hsd < Formula
  desc "Handshake Daemon & Full Node"
  homepage "https://handshake.org"
  url "https://github.com/handshake-org/hsd/archive/v2.1.2.tar.gz"
  sha256 "4fc39ee5ca2b91186847a31b3244ae5d57235720ac40812cf752bb687c0833cf"

  depends_on "python" => :build
  depends_on "node@10"
  depends_on "unbound"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    (bin/"hsd").write_env_script libexec/"bin/hsd", :PATH => "#{Formula["node@10"].opt_bin}:$PATH"
  end

  test do
    pid = spawn "#{HOMEBREW_PREFIX}/bin/hsd --prefix=#{testpath}/data"
    system "sleep", 1
    system "kill", pid
    assert_predicate testpath/"data", :exist?, "Failed to create data directory"
  end
end
