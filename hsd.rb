require "language/node"

class Hsd < Formula
  desc "Handshake Daemon & Full Node"
  homepage "https://handshake.org"
  url "https://github.com/handshake-org/hsd/archive/v2.1.3.zip"
  sha256 "d48d07d62c090d9219e8eb3fbfeae53cdff2befda42f048bd0dd50201ccfec62"

  depends_on "python" => :build
  depends_on "node@10"
  depends_on "unbound"

  def install
    system "#{Formula["node@10"].bin/"npm"}", "install", *Language::Node.std_npm_install_args(libexec)
    (bin/"hsd").write_env_script libexec/"bin/hsd", :PATH => "#{Formula["node@10"].opt_bin}:$PATH"
  end

  test do
    (testpath/"script.js").write <<~EOS
      const assert = require('assert');
      const hsd = require('#{libexec}/lib/node_modules/hsd');
      assert(hsd);

      const node = new hsd.FullNode({
        prefix: '#{testpath}/.hsd',
        memory: false
      });
      (async () => {
        await node.ensure();
      })();
    EOS
    system "#{Formula["node@10"].opt_bin}/node", testpath/"script.js"
    assert_true File.directory?("#{testpath}/.hsd")
  end
end
