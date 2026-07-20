cask "digitallife" do
  version "1.3.1"
  sha256 "009e1f428f307cf109fa55e4910e38c33840a5a5db812b30ccdcd67d4f144f10"

  url "https://github.com/Link-X/digitallife-releases/releases/download/v#{version}/DigitalLife-#{version}.dmg"
  name "DigitalLife"
  name "数字人生"
  desc "电脑活动监控，数据全程本地不外传"
  homepage "https://github.com/Link-X/digitallife-releases"

  # 自动发现新版本（GitHub Releases 最新 tag）
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura # 最低 macOS 13

  app "DigitalLife.app"

  uninstall quit: "com.digitallife.app"

  # 单源数据目录 ~/Library/Application Support/digitallife
  # （含 digitallife.db / settings.json / control.json / store_error.json）
  zap trash: [
    "~/Library/Application Support/digitallife",
    "~/Library/Caches/com.digitallife.app",
    "~/Library/HTTPStorages/com.digitallife.app",
    "~/Library/Preferences/com.digitallife.app.plist",
  ]

  caveats <<~EOS
    卸载前，建议先在 App 内使用「卸载」功能，摘除以 root 运行的能耗守护进程
    （com.digitallife.powerd，SMAppService 注册），brew 无法以 root 清理它。
    如启用过数据库加密，密钥保存在钥匙串（服务 digitallife），如需彻底清除请手动删除。
  EOS
end

