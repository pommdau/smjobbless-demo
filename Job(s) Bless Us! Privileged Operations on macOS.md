# [Job\(s\) Bless Us\! Privileged Operations on macOS](https://speakerdeck.com/vashchenko/job-s-bless-us-privileged-operations-on-macos)を読んだときのメモ

- macOSの権限昇格の話
- [AuthorizationExecuteWithPrivileges](https://developer.apple.com/documentation/security/1540038-authorizationexecutewithprivileg)はDeprecated
    - （実装自体は楽だったのですが…）

![](https://i.imgur.com/bzZBW62.jpg)


- OSが行うバリデーションは、Helperのインストールと更新のみ。
- XPC接続の確立ではバリデーションは行われない。
    - セキュリティ的に良くない

![](https://i.imgur.com/kxFszwJ.jpg)

- 1. はじめにCllientはバンドル内にHelperを持っている
- 2. 署名条件
    - ClientとHelperが署名されている
    - Privileged Helperはlaunchd用のplistを持っており、__TEXT　セクションにエンベッドされる
    - `-sectcreate`やら`__TEXT`はリンカーフラグ（理解していない所）

![](https://i.imgur.com/0xJV6CO.jpg)

- Privileged Helperはlaunchd用のplistを持っており、__TEXTセクションにエンベッドされる

![](https://i.imgur.com/NA71t9L.jpg)

![](https://i.imgur.com/g0LH3Qk.jpg)

- HelperはembedされたInfo.plistを持つ
    - HelperはCommand-Line ToolなのでそのままInfo.plistを持てないため

>https://transxcode.com/API-FolOPQR/REF_S/SPI_XYZ/XcoHelp_Fo/XCoHelp344.html
>バイナリでの Info.plist セクションの作成 (CREATE_INFOPLIST_SECTION_IN_BINARY)
>この設定を有効にすると、ターゲット用の処理された Info.plist ファイルを含む製品のリンクされたバイナリ内にセクションが作成されます。この設定は、コマンドラインツールターゲットにのみ適用されます。

![](https://i.imgur.com/q2ofeuI.jpg)

- ClientはInfo.plistに署名要件を持っている。
- [SMPrivilegedExecutables](https://developer.apple.com/documentation/bundleresources/information_property_list/smprivilegedexecutables)
    - Name: `Tools owned after installation`
    - The Service Management tools owned by the app.
- [TN3127: Inside Code Signing: Requirements](https://developer.apple.com/documentation/technotes/tn3127-inside-code-signing-requirements)
    - [リーフ証明書](https://itkq.jp/blog/2020/06/20/x509-chain/)うんぬん。

```
# identifierの確認
identifier "com.ikeh1024.SMJobBlessDemo.installer" and 

# リーフ証明書の確認と思われる
anchor apple generic and certificate leaf[subject.CN] = "Apple Development: HIROKI IKEUCHI (7B3ZX97MAS)" 
```

![](https://i.imgur.com/a5DdAej.jpg)

- 権限取得

![](https://i.imgur.com/8OxXAhS.jpg)

- OSはコード署名要求をClientとHelperのInfo.plitに対して確認する
- そしてバンドルからHelperを`Library/PrivilegedHelperTools`にコピーする

![](https://i.imgur.com/7Ns4EmT.jpg)

- ClientはXPC通信をHelperに対して行えます。

![](https://i.imgur.com/D4fYFnB.jpg)



- https://speakerdeck.com/vashchenko/job-s-bless-us-privileged-operations-on-macos?slide=52

![](https://i.imgur.com/GnPtoEl.jpg)

