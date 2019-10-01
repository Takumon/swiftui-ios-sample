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

