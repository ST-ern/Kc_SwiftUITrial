# SwiftUI Learning
A trial of swiftUI, following dlgchg's video.

Xcode Version 11.3.1 (11C504)



#### 1. brief intro

1. `command` + `shift` + `L` : open the menu of all kinds of UI components or properties. There are 5 parts : `View`, `Modifier`, `Snippets`, `Media`, `Color`.
   - `background()`
   - `cornerRadius()`
2. `control` + `I` : automatic alignment.
3. `command` + one click the aim : open its attributes inspector.



#### 2. Layout & Stack

1. VStack : vertical stack & HStack : horizontal stack

2. image resize :

   - modify `Frame` (`Width` & `Height`) in attributes inspector.
   - add property `.resizeable()` to image. ( by `command` + `shift` + `L` ).

3. `Spacer()`

4. overall(stack) resize :

   simply just modify `Frame` (`Width` & `Height`) in attributes inspector.

5. considering the **text size**, make it readable with certain size mode which can be seen at https://developer.apple.com/design/human-interface-guidelines/

6. add shadow : add property `shadow()` to stack (outermost rage)

   you must add `shadow()` **after the `background()`** (means bg must exist, and position is ordered), or there will be nothing.

7. ZStack :

   - can fulfill order in z-index

   - in ZStack, what is initialize first, would be behind; the **last** one to initialize would be at **top**.

   - how to make it?

     - choose the aim, use `command` + one click to open attributes inspector, select `embed in HStack/VStack`.

     - change `HStack/VStack` to `ZStack`.

     - add a VStack front the aim (to make UI behind the aim)

     - set VStack's bg color,cornerradius, shadows..., mostly, set `.offset()` **at last**.

       > normally, `frame()` is the **first property**, `offset()` is the **last**.
       >
       > example: 
       >
       > ```swift
       > .frame(minWidth: 0, maxWidth: .infinity)
       > .padding()
       > .padding(.horizontal)        
       > .background(Color.white)
       > .cornerRadius(30)
       > .shadow(radius: 20)
       > .offset(y:600)
       > ```



#### 3. Components & Visual Effects

1. Components : which can be used once and once again.

   - choose the stack you want to make a components.
   - use `command` + one click to open attributes inspector, select `Extract Subview`.
   - name ths subview first, then you will find a new struct at the end of codes. (can also find the struct by  `command` + one click the subview, choose `jump to definition`)

   > - you better **not set offset** in the definition of struct which will be used multiple times. (set offset when each time use it)

2. `.scaleEffect()`, find it by searching 'scale' in `Modifier` (`command` + `shift` + `L` )

3. `.rotationEffect()`,  find it by searching 'rotation' in `Modifier` (`command` + `shift` + `L` ), **which attribute has model `Angle(degrees: Double)`**.

4. `.rotation3DEffect()`,  same to `rotationEffect()` with an axis attribute.

   > you can set rotation & rotation3D *at the same time*.

5. `.blendMode()`, change the visual effect of overlap images(layers), like *Darken, Overlay, Soft Light, Hard Light...* (these four use more often).

6. `lineLimit()` : the texts' limitation of line, found in attributes inspector.

7. `.opacity()` : same function like css.

8. space setting : not only by set padding one by one, you can set `Spacing` in stack's attributes inspector to adjust every component in stack.

9. `.padding()` : function to add default padding, **can be multiply used** to fulfill multiple effect. can add attributes like `.padding(.horizontal)`.

10. `.blur()` : matually code, to fulfill the blur effect.



#### 4. Animations and States

1. the basic of animations is a boolean type flag to differ the states (like `@State var flag = true/false`)

2. change the attribute of previous function to judgement type like `flag ? one : another`. (don't ignore blank) These can used in `offset, rotation(3D)Effect, blur, background...`

   > yeah, even bg color can be animation

3. `.animation()` : to fulfill different kinds of animations. (such as: `.default, .linear, .easeInOut`... can also set duration time by add `(duration: 0.7)`)

4. `Command` + `/` : to turn code into comment

5. `Command` + `X` : copy and delete

6. gesture example: tap gesture

   ```swift
   .onTapGesture {
       self.show.toggle() // means change the value of 'show' when click
   }
   ```

7. each kind of animation's attributes can be found by `find definition`.



#### 5. Gesture and Events

1. drag gesture : to fulfill a moving animation

   - set a CGSize var to means a position, like `@State var viewState = CGSize.zero` (CGSize.zero is default value, zero position)

   - set the drag gesture where you want to make the drag gesture

     ```swift
     .gesture(
         DragGesture()
         	.onChanged { value in
                 self.viewState = value.translation
                 self.show = true
             }
             .onEnded { value in
                 self.viewState = CGSize.zero
                 self.show = false
             }
     )
     ```

     watch out the model. it seems like css.

     - `.gesture()` : gesture function
     - `DragGesture()` : drag gesture about
     - `.onChanged {}  .onEnded {}` : drag gesture state
     - `value in` : get value (from gesture), `value.translation` is a position

   - `.offset(x: viewState.width, y: viewState.height)`

     by set offset to make components move with drag gesture.



#### 6. SF Symbols and Props

1. apply SF symbols:

   - `command` + `shift` + `L`, search `Image`, drag to the scene
   - input attribute: `systemName: String`. (find names in SF app)

   > 2x & 3x screen's difference?

2. better set certain frame for SF symbols, it seems that **32*32** is perfect enough.

3. don't use SF symbols with '!' everywhere (they are with certain use condition).

4. by set certain `var` in definition make subtract can have attributes, like:

   ```swift
   struct MenuRow: View {
       var image = "creditcard"
       var text = "My Account"
       var body: some View {
           HStack {
               Image(systemName: image)
                   .frame(width: 32.0, height: 32.0)
                   .imageScale(.medium)
                   .foregroundColor(Color("icons"))
               Text(text)
                   .font(.headline)
           }
       }
   }
   ```

   then you can use it by sth like this:

   ```swift
   MenuRow(image: "arrow.uturn.down", text: "Sign out")
   ```

5. if you want to make middle components to margin, try to add `Spacer()` in the stack.

6. `padding()` attributes has `.trailing, .top, ` ...



#### 7. Create a List with Data

1. How?

   - make a struct to contain the content you need, like:

     ```swift
     struct Menu: Identifiable { // if want to handle a element in list, type is must Identifiable
         var id = UUID()  // necessary
         
         var title: String
         var icon: String
     }
     ```

     every struct you make must add `var id = UUID()` in it.

   - make a list var:

     ```swift
     let menuDate = [
         Menu(title: "My Account", icon: "person.crop.circle"),
         Menu(title: "Billing", icon: "creditcard"),
         Menu(title: "Team", icon: "person.and.person"),
         Menu(title: "Sign out", icon: "arrow.uturn.down"),
     ]
     ```

   - use this var in main struct :

     ```swift
     var menu = menuDate
     ```

   - use `ForEach` function to generate a visible list:

     ```swift
     VStack(alignment: .leading, spacing: 20.0) {
     	ForEach(menu) { item in  // watch out the format ( item in )
     		MenuRow(image: item.icon, text: item.title)
         }
         Spacer()
     }
     
     ```




#### 8. Menu Animation and Binding

1. `.offset(x: show ? 0 : -UIScreen.main.bounds.width)`, which can make sth move just out of screen.

2. when make subtract, we need to pass value in main struct to subtract, use `Binding`:

   - in your subtract, identify *a binding var* with their type

     ```swift
     struct MenuView: View {
         @Binding var show: Bool
         ...
     }
     
     ```

   - then go to main struct, add var which need to pass where you use the subtract, like:

     ```swift
     @State var show = false
     ...
     MenuView(show: $show) // remember the '$' char
     
     ```

     it seems like reference in c++, which can pass the change of var.



#### 9. Animation Bstween Screens

1. floating buttons:

   watch the `shadow` part:

   ```swift
   HStack {
       Image(systemName: icon)
       .foregroundColor(.black)
   }
   .frame(width: 44, height: 44)
   .background(Color.white)
   .cornerRadius(30)
   .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)// y make it like foating
   
   ```

2. mutiple screen

   simply use another screen view struct in your temporary view struct. 

   remember put in a zstack.

3. components jump from margins can use `.spring()` as animation attribute.



#### 10. Scrolling your Content

1. make a unit component (for example:)

   ```swift
   struct CourseView: View {
       var body: some View {
           VStack(alignment: .leading) {
               Text("Build an app with SwiftUI")
                   .font(.title)
                   .fontWeight(.bold)
                   .foregroundColor(Color.white)
                   .padding(20.0)
                   .lineLimit(4)
                   .frame(width: 150.0)
               Spacer()
               Image("Illustration1")
               
           }
           .frame(width: 246.0, height: 360.0)
           .background(Color("background3"))
           .cornerRadius(30)
           .shadow(color: Color("backgroundShadow4"), radius: 20, x: 0, y: 20)
       }
   }
   
   ```

2. put in into a recycle to multiple it:

   ```swift
   ForEach(0 ..< 3) { item in
   	CourseView()
   }
   
   ```

3. put it into a stack (`HStack`/`VStack` to scroll horizontal/vertical), then embed in `ScrollView` (`embed in Group` and change name).

   use `ScrollView(.horizontal)` to fulfill horizontal scrolling.

   ```swift
   ScrollView(.horizontal, showsIndicators: false) {
       HStack {
           ForEach(0 ..< 3) { item in
               CourseView()
           }
       }.padding(.bottom, 50)  // to make shadows not be cut, make stack's padding
   }
   
   ```



#### 11. Model Presentation

1. change different view: old time use `PresentationButton` which is no longer used any more.

   so how???

2. in card view:

   - adjust image size with these:

     ```swift
     Image(image)
         .resizable()  // adjust size to align
         .renderingMode(.original)
         .aspectRatio(contentMode: .fit)  //!
         .frame(width: 246.0, height: 150.0)  // make a frame to surance max size
         .padding(.bottom, 30)  // bottom padding to align
     
     ```

   - if there is any text align problems, remember that **better not set frame to text**, but  use **padding** to align (left and right). (because of the text content will cause different align effect while using frame).



#### 12. Background Blur

1. use `UIBlurEffect` and  `UIVisualEffect`.

   code like this (dont need to learn):

   ```swift
   struct BlurView: UIViewRepresentable {
       
       let style: UIBlurEffect.Style
       
       func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
           let view = UIView(frame: .zero)
           view.backgroundColor = .clear
           let blurEffect = UIBlurEffect(style: style)
           let blurView = UIVisualEffectView(effect: blurEffect)
           blurView.translatesAutoresizingMaskIntoConstraints = false
           view.insertSubview(blurView, at: 0)
           NSLayoutConstraint.activate([
               blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
               blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
           ])
           return view
       }
       
       func updateUIView(_ uiView: UIView, 
                         context: UIViewRepresentableContext<BlurView>) { }   
   }
   
   ```

2. then just add `BlurView` into your view, with attributes `.dark`, `.light`, `.extralight`

   ```swift
   BlurView(style: .extraLight)
   
   ```

3. you can also use `.blur(radius: Double)` to make blur, but whis will make a **whole stack** bacome blur, can fulfill the blur *layer* effect.



#### 13. Navigation View and List

1. navigation view simply made by a `NavigationView`, which contains a list of `NavigationLink`s and a `.navigationBarTitle`, or maybe some `.navigationBarItems` :

   ```swift
   NavigationView {
       List(updates) { item in  // recycle
   		NavigationLink(destination: Text("1")) { // each link is a list line, destination is where line goes
   			VStack(alignment: .leading) {  // this view is what line shows
   				Text(item.title)
   					.font(.headline)
   				Text(item.text)
                       .font(.subheadline)
                       .lineLimit(2)
                       .frame(height: 50.0)
                       .lineSpacing(4)
                   Text(item.date)
                       .font(.caption)
                       .fontWeight(.bold)
                       .foregroundColor(Color.gray)
                   }  // these font, weight & color is an example of default list
               }
   	}
       .navigationBarTitle(Text("Updates"))  // navigation list's title (also back button after click into certain line)
       .navigationBarItems(trailing: EditButton() )  // other title items (like buttons)
   }
   
   ```

   

#### 14. Navigation and Passing Data

1. add image to line: make a HStake

2. Navigation: change the `NavigationLink(destination: ...)` destination attribute to a new view.

   - passing data:

     in the main View struct, add var will make this page(view) can receive data, like:

     ```swift
     struct UpdateDetail: View {
         var title = "SwiftUI"
         var text = "Loading..."
         var image = "Illustration1"
         var body: some View {
             ......
         }
     }
     
     ```

     the `UpdateDetail` struct can receive attributes when used.

   - define the `destination` and pass value with cycle item.

     ```swift
     List(updates) { item in
         NavigationLink(destination: UpdateDetail(title: item.title,
                                                  text: item.text,
                                                  image: item.image)
                       ) {
                         ...
         }
     }
     
     ```



#### 15. Combine and Edit Mode

1. connect with storage:

   add a new file, without ui, make a `ObservableObject` class and `@Published` a var, initialize it.

   ```swift
   class UpdateStore: ObservableObject {
       // use to add data to storage
       let didChange = PassthroughSubject<Void, Never>()
       
       @Published var updates: [Update] = []
       
       // initialize
       init(updates: [Update] = []) {
           self.updates = updates
       }
   }
   
   ```

   then class `UpdateStore` is just like variable store in backend.

   in certain ui file, add a `ObservedObject` and pass the var to it (`@Published` one).

   ```swift
   @ObservedObject var store = UpdateStore(updates: updateDate) // dynamic value
   
   ```

   then you can change the static list value in `ForEach` function to `store.updates`.

2. add, remove, move and order

   - add: make a button, write a click function to add item to `store.updates`

     ```swift
     func addUpdate() {
         store.updates.append(Update(image: "Certificate1", title: "New Title", text: "New Text", date: "JUN 1"))
     }
     ...
     Button(action: addUpdate) {
         Text("Add Update")
     }
     
     ```

   - other function, make sure in `ForEach` logic.

   - remove: add `onDelete` function after `}` of `ForEach` to remove a index.

     ```swift
     .onDelete { indexSet in  // reflect a line in list
         self.store.updates.remove(at: indexSet.first!) // don't forget '!'
     }
     
     ```

   - move: add `onMove` function bind to a function you write.

     ```swift
     func move(from source: IndexSet, to destination: Int) {
         #warning("not use swap!!! crash!!!")
         store.updates.move(fromOffsets: source, toOffset: destination)
     }
     ...
     .onMove(perform: move)
     
     ```

   - order: simply write a `EditButton` behind the `}` of `List`.

     ```swift
     .navigationBarItems(trailing: EditButton() )
     
     ```

   

#### 16. Tab Bar and Test on Device

1. bottom menu is the most important part for user to use, while side menu is not much useful (because bottom can be clicked by only one finger's one touch, which is convinient).

2. how to build?

   - from `SceneDelegate` make a new swift file called `TabBar`

   - add a `TabView` in its body, set every column of the tab bar and connect to the page view

     ```swift
     TabView {  // add a TqbView
         Home().tabItem {  // make a image and text, bind to Home view
             Image("IconHome")
             Text("Home")
         }
         .tag(1)  // make this column in col 1
         ContentView().tabItem {
             Image("IconCards")
             Text("Certificate")
         }
         .tag(2)
         UpdateList().tabItem {
             Image("IconSettings")
             Text("Updates")
         }
         .tag(3)
     }
     
     ```

   - then find `rootViewController` in `SceneDelegate.swift`, change the `rootView:` to tab view. 





#### 17. Dark Mode and Acessibility

1. how to debug with dark mode?

   in `TabBar.swift`, change the `TebBar_Previews` struct : add `.environment(\.colorScheme, .dark)` after the initialize (use).

2. change settings:

   - chang stacks' `background` color from certain color to `BlurView(style: .systemThickMaterial)` [`BlurView` has been defined before].
   - for img(sign), change `.foregroundColor` from certain color to `.primary`.

3. you can also change text size mode for debugging in `TabBar.swift`, change the `TebBar_Previews` struct : add `.environment(\.sizeCategory, .extraLarge)` after the initialize (use).



#### 18. Update Code for Beta Releases*

1. `command`+`B` : rebuild codes



#### 19. Form and Controls

1. `NavigationView` : default setting / login page view, which is widely suitable.
2. `Form` : just like `List`, additionally it can push data.
3. `Toggle`: open / close, need a var to judge. 
4. `Stepper` : count and select numbers, need a ver to store number
5. `Picker` : selecting part, need a var to store selection index
6. `DataPicker` : need a var with `Date()` type.
7. alert of button: add `.alert(isPresented: $submit) {}` after button to set alert after click button

```swift
NavigationView {
            Form {
                Toggle(isOn: $receive) {
                    Text("Receive notifications")  // text is on left of line
                }
                Stepper(value: $number, in: 1...10) {
                    Text("\(number) Notification\(number > 1 ? "s" : "") per week")
                    // text on left of line
                }
                Picker(selection: $selection, label: Text("FavoriteCourse")) {
                    // text of 'label' on left, text below on right as selected one
                    Text("SwiftUI").tag(1)
                    Text("React").tag(2)
                }
                DatePicker(selection: $date, label: { Text("Date") })
                // text of 'label' on left (as name)
                Section(header: Text("Email")) {  
                // section just like Stack but has a header
                    TextField("Youremail", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // text is what input will be represent whole line
                }
                Button(action: { self.submit.toggle() }) {
                    Text("Submit")
                }
                .alert(isPresented: $submit) {  // set alert message
                    Alert(title: Text("Thanks"), message: Text("Email: \(email)"))
                }

            }
        .navigationBarTitle("Settings")  // navigation title
        }

```

9. how to add code & var in string : use `\()`, then add code & var between `(` and `)`.

