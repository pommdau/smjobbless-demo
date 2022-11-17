# SMJobBless
## サンプルアプリ

<img width="800" alt="image" src="https://i.imgur.com/TG54l6i.png">

## 参考
### aronskaya
- [aronskaya/smjobbless](https://github.com/aronskaya/smjobbless#used-definitions)
    - 実際に動かせる良サンプル
- [Securing XPC Connection](https://github.com/aronskaya/smjobbless/blob/master/SecuringXPCConnection.md)
    - コードの説明
- [Job\(s\) Bless Us\! Privileged Operations on macOS](https://speakerdeck.com/vashchenko/job-s-bless-us-privileged-operations-on-macos)
    - 説明用スライド
    - Appleのサンプルコードは古く、実装時にセキュリティで気にすべき点が書かれている。

### SMJobBless
- [SMJobBlessサンプルのビルド作業](http://www.olt.tokyo/docs/SMJobBless/index.html)
    - 概念がわかりやすい解説

### XPC接続
- [TN3113: Testing and debugging XPC code with an anonymous listener](https://developer.apple.com/documentation/technotes/tn3113-testing-xpc-code-with-an-anonymous-listener)
    - AppleのXPCに関するドキュメント。最近のもの。
- https://medium.com/dwarves-foundation/xpc-services-on-macos-app-using-swift-657922d425cd
    - XPCに関して。

### launchedとは
- [launchd](https://ja.wikipedia.org/wiki/Launchd)
- [Macの「ターミナル」でのlaunchdを使ったスクリプトの管理](https://support.apple.com/ja-jp/guide/terminal/apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac)

### Daemon/Agentとは
- [LaunchDaemons \(launchctl, launchd\.plist\) の使い方](http://www.maruko2.com/mw/LaunchDaemons_(launchctl,_launchd.plist)_%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9)
- https://developer.apple.com/library/archive/technotes/tn2083/_index.html#//apple_ref/doc/uid/DTS10003794-CH1-SECTION2
- [MacOSのデーモンをマスターしよう：Launchdプロセス](https://qiita.com/spc_gmorimoto/items/b7ba5d69a00e277bb259)

### 岸川さんの例(詳しくはまだ見ていない)
- https://discord.com/channels/559324435530776576/559354434518515718/839463498538156102
- [kishikawakatsumi/BandwidthLimiterPublic](https://github.com/kishikawakatsumi/BandwidthLimiter/blob/4561b5efe52ccda4042b6008c586e94b9b7fa4fa/BandwidthLimiter/ExecutionServiceProxy.swift)

### (読めたら読む)
- [Easy to use SMJobBless, along with a full Swift implementation of the Authorization Services and Service Management frameworks](https://swiftobc.com/repo/trilemma-dev-Blessed)
  - 簡単に扱えるらしいライブラリ
- [trilemma\-dev/Blessed](https://github.com/trilemma-dev/Blessed)
- [trilemma\-dev/SwiftAuthorizationSample](https://github.com/trilemma-dev/SwiftAuthorizationSample)
    - こちらも良いことが書いていそう

### 証明書
- [Apple Developer Programの証明書（Certificates）の種類まとめ](https://qiita.com/daimyo404/items/69392d62c2eac4299d12)
    - 試したところ`Developer ID Application`もしくは`Apple Development:`だとうまくいくが、`Developer ID Installer`だとうまく権限が取得できないようである。

>[Mac App Store への公開ガイド](https://www.electronjs.org/ja/docs/latest/tutorial/mac-app-store-submission-guide)
>"Developer ID Application" 証明書は、アプリを Mac App Store 以外で頒布する前の署名に使用します。

- App Store外で配布するときに下記より公証を行う。
- その際の署名は`Developer ID Application: HIROKI IKEUCHI (BWMJMJK727)`となるので、ローカルのデバッグ時もこちらを使うと良さそう。

![image](https://user-images.githubusercontent.com/29433103/201918686-a8a00f63-a379-435c-b31e-1dfcc82f4bde.png)

