# OpenVPNTunnelKit — releases

Public distribution point for `OpenVPNTunnelKit`, the OpenVPN client (openvpn3 core with XOR
scramble) used inside `NEPacketTunnelProvider` on iOS and macOS.

This repository carries no source code. It holds two things:

```
releases/<version>/OpenVPNTunnelKit.xcframework.zip   the binary the podspec downloads
OpenVPNTunnelKit/<version>/OpenVPNTunnelKit.podspec   the CocoaPods spec repo tree
```

Because the download is plain HTTPS, consuming projects need no access to the private sources and
no GitHub credentials.

## Using the pod

```ruby
source 'https://cdn.cocoapods.org/'
source 'https://github.com/Daniloday/OpenVPNXor-Releases.git'

platform :ios, '15.0'
use_frameworks!

target 'App' do
  pod 'OpenVPNTunnelKit', '~> 0.2'
end

target 'PacketTunnel' do
  pod 'OpenVPNTunnelKit', '~> 0.2'
end
```

The pod belongs to both targets: the extension links the framework, the app embeds it. The binary
is built with `BUILD_LIBRARY_FOR_DISTRIBUTION=YES` and marked app-extension-safe.

Declaring the CDN source explicitly is required — as soon as a Podfile names any custom source,
CocoaPods stops consulting the default one, and every other pod would fail to resolve.

## Cutting a release

From the private sources repository:

```sh
# bump s.version in OpenVPNTunnelKit.podspec first
Scripts/release.sh
```

That builds the three slices (ios-arm64, ios-arm64_x86_64-simulator, macos-arm64_x86_64), zips the
framework together with LICENSE and NOTICE, and writes both the zip and the podspec into this
repository. Then, from here:

```sh
git add releases OpenVPNTunnelKit && git commit -m "OpenVPNTunnelKit 0.2" && git push
```

The push has to land before the spec is linted or installed: the podspec's `:http` URL points at
the zip in this repository, so it only resolves once the commit is public.

## Archive size

Each release adds roughly 5 MB to this repository, and CocoaPods clones a spec repo in full. If the
history grows uncomfortable, upload the zips as GitHub release assets instead of committing them
and point `releases_raw` in the podspec at the asset URL — nothing else changes for consumers.

## Licence

The distributed binary is covered by AGPLv3; LICENSE and NOTICE travel inside every release zip.
