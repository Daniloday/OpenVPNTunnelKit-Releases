# Distribution podspec for the prebuilt OpenVPNTunnelKit binary.
#
# The pod ships as a zipped xcframework hosted in the public releases repository, so consuming
# projects need no access to these sources -- only plain HTTPS. Sources live in the private
# repository; Scripts/release.sh produces the zip and copies this spec into the releases repo.

# Public repository that hosts the release zips and serves as the private CocoaPods spec repo.
# A local variable rather than a constant: CocoaPods evaluates a podspec more than once per run.
releases_repo = "https://gitlab-ci.cdin.me/ios/openvpnxor-releases"

Pod::Spec.new do |s|
  s.name     = "OpenVPNTunnelKit"
  s.version  = "0.1.0"
  s.summary  = "OpenVPN client (openvpn3 core with XOR scramble) for iOS and macOS NetworkExtension, shipped as a binary xcframework."
  s.description = <<-DESC
    Objective-C++/Swift wrapper around the openvpn3 core (mbedTLS, LZ4, XOR scramble patch) for use inside
    NEPacketTunnelProvider on iOS and macOS. Distributed as a prebuilt OpenVPNTunnelKit.xcframework produced by
    Scripts/build-xcframework.sh (slices: ios-arm64, ios-arm64_x86_64-simulator, macos-arm64_x86_64).
  DESC

  s.homepage = releases_repo
  s.license  = { :type => "AGPLv3", :file => "LICENSE" }
  s.author   = "Futurra Group"

  # Binary release archive: OpenVPNTunnelKit.xcframework + LICENSE + NOTICE at the zip root.
  s.source = {
    :http => "#{releases_repo}/-/raw/main/releases/#{s.version}/OpenVPNTunnelKit.xcframework.zip"
  }

  s.ios.deployment_target = "15.0"
  s.osx.deployment_target = "12.0"
  s.swift_version = "5.0"

  # Paths are relative to the root of the unpacked archive, not to this repository.
  s.vendored_frameworks = "OpenVPNTunnelKit.xcframework"

  s.frameworks     = "Foundation", "NetworkExtension", "SystemConfiguration"
  s.ios.frameworks = "UIKit"
end
