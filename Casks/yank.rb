cask "yank" do
  version "0.7.38"
  sha256 "59e4f090ebae973e0b5b07e3a1df7ecdc2283256f5b0a56a8757d82a1f67d99f"

  url "https://github.com/piyushpradhan/yank/releases/download/v#{version}/Yank_#{version}_aarch64.dmg",
      verified: "github.com/piyushpradhan/yank/"
  name "Yank"
  desc "Clipboard manager with natural-language search"
  homepage "https://yankapp.io"

  livecheck do
    url "https://github.com/piyushpradhan/yank/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "Yank.app"

  zap trash: [
    "~/Library/Application Support/com.getyank.app",
    "~/Library/Caches/com.getyank.app",
    "~/Library/Logs/Yank",
    "~/Library/Preferences/com.getyank.app.plist",
    "~/Library/Saved Application State/com.getyank.app.savedState",
  ]
end
