# 美劇看看

![](https://raw.githubusercontent.com/shinrenpan/MGKK/master/MGKK/Images.xcassets/AppIcon.appiconset/Icon-76.png)

[Demo video](http://youtu.be/NSdrNZ7s49I)

美劇看看是一款 iOS universal app, 使用者可以在 App 上觀看美劇, 管理者可以透過 [LeanCloud](https://leancloud.cn) 上架資料.

## Why open source

原本想說上架後就可以上其他如韓劇看看, 日劇看看, Whatever 看看, 不過違反了下列 Review guideline.

雖然 App Store 上很多這種 App, 但 Apple Review Team 還是不讓我上架, 最後只說了一句 `No Response Needed`, 還真的不知道審核的標準在哪.

>8.5
>Apps may not use protected third party material such as trademarks, copyrights, patents or violate 3rd party terms of use. Authorization to use such material must be provided upon request

## 編譯

iOS 8 or later

此 App 使用以下 framework, 編譯前請先下載並設置

[Ono](https://github.com/mattt/Ono)

[AdMob](https://apps.admob.com/)

[LeanCloud](https://leancloud.cn) iOS Framework

[SRPBlurPresentation](https://github.com/shinrenpan/SRPBlurPresentation)

## 後台建置

本 App 使用 [LeanCloud](https://leancloud.cn) 當後台, 你必需建置相關環境才能使用此 App.

### Table

本 App 僅使用一個 Table, 命名為 Dramas

### 欄位

Dramas Table 共有 4 個欄位 (都小寫), 分別為:

- __data ( JSON Array )__

資料格式為 JSON Array 格式, 放置影片網址, 例如:
```json
[
	"http://www.letv.com/ptv/vplay/20829751.html",
	"http://www.letv.com/ptv/vplay/20910588.html",
	"http://www.letv.com/ptv/vplay/20995758.html",
	"http://www.letv.com/ptv/vplay/21053315.html"
]
```

- __enable ( BOOL )__

是否上架, true 代表使用者可以看到此影集列表, false 反之.

- __finish ( BOOL )__

是否完結, true 代表此影集已經完結, false 反之, 使用者會在列表上看到 `已完結` 或是 `連載中` 字樣.

- __name (String)__

影集名稱, 命名季數時, 最好使用 2 位數, 例如使用`神盾局特工 第02季`, 而不是使用`神盾局特工 第2季`, 不然 Order by name 會排序錯誤.

設置完應該如下圖:

![](README/1.png)

## 其他

本 App 只是單純去爬 [flvxz](http://www.flvxz.com) 頁面, 其實沒用到什麼高超的技術.

你在上傳新的影片到 [LeanCloud](https://leancloud.cn) 前, 最好利用 [flvxz](http://www.flvxz.com) 查看是否有影片連結.

如果有其他問題請開 Issue

## 我是否能把 App 送審上架:

非常歡迎你送審, 如果 Apple 審核通過請來信告知.

## 贊助

我之後會陸續將無法送審的 App 開源, 如果你想贊助, 可以透過以下方法:

### Paypal:

[![PayPayl donate button](https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LC58N7VZUST5N "Donate")

### AdMob:

你可以在你的 App 使用我的 AdMob Id:`ca-app-pub-9003896396180654/4692599394`

## License

MIT License
