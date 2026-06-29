cask "yank" do
  version "0.7.51"
  sha256 "773456564464702173a5a572efe9915c1c89155c8ad0e9e408f8a951d87b67b3"

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

  # Tauri ships the macOS bundle linker-signed with no sealed
  # resources, which macOS rejects as "damaged" on first launch.
  # Strip any stray xattrs Brew may have left, then re-apply a
  # proper ad-hoc signature with sealed resources so the validity
  # check passes. No Developer ID needed.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Yank.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Yank.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.getyank.app",
    "~/Library/Caches/com.getyank.app",
    "~/Library/Logs/Yank",
    "~/Library/Preferences/com.getyank.app.plist",
    "~/Library/Saved Application State/com.getyank.app.savedState",
  ]
end
