# SwiftUI Learning
A trial of swiftUI, following dlgchg's video.


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

     
