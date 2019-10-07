# SwiftUI Sample Application

## SwiftUI

* XCode11(9/20/2019)からサポート
* View(Swiftファイル)で簡単に画面レイアウトが定義できる。
* モデルの変更をViewに反映させる仕組みが用意されている。

## Viewの実装方法

ViewはStructで実装

```swift
import SwiftUI

// View Protocolを実装
struct TaskItemView: View {

    // 画面に表示するデータを定義
    var task: Task

    // bodyを実装
    var body: some View {
        // 画面レイアウトを定義
        Text(task.title)
    }
}

// XCode用の画面プレビューを定義
#if DEBUG
// PreviewProviderを実装
struct TaskItemView_Previews: PreviewProvider {
    // previewsを定義
    static var previews: some View {
        // プレビュー用のViewを定義
        // 画面に表示するデータはプレビュー表示用のものを使う
        TaskItemView(task: Task.getDefault())
    }
}
#endif
```

以下のように画面に配置したい要素を定義していく。

```swift
    var body: some View {
        VStack {
            Image("ic_news_placeholder")
                .frame(width: UIScreen.main.bounds.width - 100, height: (UIScreen.main.bounds.width - 100)  * 0.5 as CGFloat, alignment: Alignment.center)
                .scaledToFill()
            
            Text(verbatim: article.title)
            
            HStack {
                Image(uiImage:  #imageLiteral(resourceName: "ic_publish"))
                .
                    .frame(width: CGFloat(20.0), height: CGFloat(20.0), alignment: Alignment.center)
                Text(article.publishedDateStr)
            }
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
            
            HStack {
                Image(uiImage:  #imageLiteral(resourceName: "ic_author"))
                    .frame(width: CGFloat(20.0), height: CGFloat(20.0), alignment: Alignment.center)
                Text(article.sourceName)
                    .font(.subheadline)
            }
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))

            Text(article.description)
                .lineLimit(100)
                .font(.subheadline)
                .padding(.top, CGFloat(16.0))
        }
        .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
        .offset(x: 0, y: -180)
        .padding(.bottom, -180)
    
    }
```

## Modelの実装方法

Modelのデータに変更があった時に、再描画するには`ObservableObject`を使う

```swift
class Task: ObservableObject {
    // Model変更時に再描画するには@Publishedを付与する
    @Published var title: String

    init(title: String) {
        self.title = title
    }
}
```

View側でモデルを定義する時は`@ObservedObject`を使う

```swift
struct TaskItemView: View {

    // (中略)

    @ObservedObject var task: Task = Task(title: "Sample Task Title")

    // (中略)
}
```

## Viewでプロパティに変更時に再描画する方法

Viewに定義したプロパティの値が変更された時に再描画したい場合は`@State`を使う

```swift
struct TaskItemView: View {

    // (中略)

    @State isEditing: Bool

    // (中略)

}
```

## 1つのModelを複数のViewで共有する

Modelの定義は全章と同様

Viewの定義で、`@State`,  `@ObservedObject`　の代わりに`@EnvironmentObject`を使う

```swift
struct TaskItemView: View {

    // (中略)

    // 宣言のみ
    @EnvironmentObject var task: Task
    
    // (中略)
}
```

View生成時にenvironmentObjectメソッドでModeleを渡す

```swift
var task = Task()

// View生成時にenvironmentObjectメソッドにてModelを渡す
TaskListView().environmentObject(task)
OtherView().environmentObject(task)

```

## 1つのModelを親子Viewで共有する

```swift
struct TaskItemView: View {
    @State var title: String

    var body: some View {
    VStack {
        // 値を渡す時に、変数名の頭に`$`をつける
        TextField(Text("input"), text: $title)
    }
}
```

## 画像

`Assets.xcassets` に解像度別(x1,x2,x3)に画像を格納する。
ソースコードでは、`Assets.xcassets`上の名前で呼び出せる。
例:`Image("ic_news_placeholder")`



## ルートViewを指定する


```swift
import SwiftUI


// @UIApplicationMainをつけるとアプリのメインクラスとして認識される
@UIApplicationMain
class SceneDelegate: UIResponder, UIWindowSceneDelegate, UIApplicationDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window

            // sceneメソッド中で、UIHostingControllerを生成しルートControllerとして登録する
            // UIHostingControllerを生成時にルートViewを指定する
            let vc = UIHostingController(rootView: TaskListView().environmentObject(UserData()))
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
}
```

## 画面遷移

NavigationLinkの場合`destination`に遷移先Viewを指定する

```swift
import SwiftUI

struct TaskItemView: View {
    
    let task: Task

    var body: some View {
        NavigationLink(destination: TaskEditView(task: task)) {
            Text(task.title)
        }
    }
}
```



## Main Libraries in iOS App

* [Top 10 iOS Swift Libraries Every iOS Developer Should Know About | Infinum](https://infinum.co/the-capsized-eight/top-10-ios-swift-libraries-every-ios-developer-should-know-about)

### UI
[SwiftUI](https://developer.apple.com/xcode/swiftui/)

* [30 Auto Layout Best Practices for Xcode 10 Storyboards and iOS 12](https://blog.supereasyapps.com/30-auto-layout-best-practices/)

### REST API Call
[Alamofire](https://github.com/Alamofire/Alamofire) or [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
* [The best way to use REST APIs in Swift - arteko - Medium](https://medium.com/@arteko/the-best-way-to-use-rest-apis-in-swift-95e10696c980)

Mapper -> [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
* [tristanhimmelman/ObjectMapper: Simple JSON Object mapping written in Swift](https://github.com/tristanhimmelman/ObjectMapper)
* [Modeling REST Endpoints With Enums in Swift - The Startup - Medium](https://medium.com/swlh/modeling-rest-endpoints-with-enums-in-swift-18965f30ee94)

### Async Programming
[Combine](https://developer.apple.com/documentation/combine/)(Not [RxSwift](https://github.com/ReactiveX/RxSwift)
)

* [Will Combine kill RxSwift? - Flawless iOS - Medium](https://medium.com/flawless-app-stories/will-combine-kill-rxswift-64780a150d89)
* [RxSwift vs. Combine Wrap-Up — Liss is More](https://www.caseyliss.com/2019/6/21/rxswift-vs-combine-wrap-up)
* [heckj/swiftui-notes: A collection of notes, project pieces, playgrounds and ideas on learning and using SwiftUI and Combine](https://github.com/heckj/swiftui-notes)
* [URLSession and the Combine framework - The.Swift.Dev.](https://theswiftdev.com/2019/08/15/urlsession-and-the-combine-framework/)
* [[Swift] はじめてのCombine | Apple製の非同期フレームワークを使ってみよう ｜ DevelopersIO](https://dev.classmethod.jp/smartphone/swift-combine-framework-for-beginners/)
* [【iOS】Combineフレームワークまとめ - Qiita](https://qiita.com/shiz/items/5efac86479db77a52ccc)
### Error Handling

* [Error handling in Combine explained with code examples - SwiftLee](https://www.avanderlee.com/swift/combine-error-handling/)
* [Top-down iOS error architecture - Bartosz Polaczyk - Medium](https://medium.com/@londeix/top-down-error-architecture-d8715a28d1ad)
* [Swift 5 のResultに備える - Qiita](https://qiita.com/koher/items/7e92414082476fb87b76)

### Localization

* [Localizing Content for Swift Playgrounds - WWDC 2017 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2017/410/)


### Managing Local Data

[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults), [Core Data](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/index.html), [CoreStore](https://github.com/JohnEstropia/CoreStore)


* [Introduction to using Core Data with SwiftUI - a free SwiftUI by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftui/introduction-to-using-core-data-with-swiftui)
* [Core Data Best Practices - WWDC 2018 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2018/224/?time=7)
* [How to configure Core Data to work with SwiftUI - a free SwiftUI by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftui/how-to-configure-core-data-to-work-with-swiftui)
* [andrewcbancroft/BlogIdeaList-SwiftUI](https://github.com/andrewcbancroft/BlogIdeaList-SwiftUI)
* [Core DataをSwift 4で使う (iOS 10以降) - Qiita](https://qiita.com/da1ssk/items/3b1b9c11106717a5a935)

### Unit Test, Testing in iOS Device

[XCTest](https://developer.apple.com/documentation/xctest), TestFlight

* [Testing in Xcode - WWDC 2019 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2019/413)
* [WWDC 2018 Wishlist for Native  Developer and DevOps Tools – XCBLOG](http://shashikantjagtap.net/wwdc-2018-wishlist-for-native-%EF%A3%BF-developer-and-devops-tools/)
* [Unit tests best practices in Xcode and Swift - SwiftLee](https://www.avanderlee.com/swift/unit-tests-best-practices/)
* [Steps to put your app on TestFlight - Daniel Mathews - Medium](https://medium.com/@dmathewwws/steps-to-put-your-app-on-testflight-and-then-the-ios-app-store-10a7996411b1)

### Releasing iOS App

// TODO

### Auto Update in iSO App

// TODO

### Best Practices

// TODO
