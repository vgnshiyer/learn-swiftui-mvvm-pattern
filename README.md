//
//  README.md
//  animeapp
//
//  Created by Vignesh Iyer on 11/21/25.
//

## The Model View View Model (MVVM) Pattern

The Model–View–ViewModel (MVVM) pattern is a software architecture commonly used in UI frameworks like SwiftUI.

1. Model

* The data and the business logic of your app.
* Should be completely UI-independent.

**Examples:**

* A User struct
* A network response object
* A database entity

2. View

* The UI — what the user sees.
* In SwiftUI, this is your View structs.
* The View should be as “dumb” as possible: it shows data and sends user actions to the ViewModel.

3. ViewModel

* The bridge between the Model and the View.
* Holds UI state.
* Fetches and transforms data before passing it to the View.
* Handles user input and commands.
* Not tied to any specific UI framework (in theory).

In SwiftUI, the ViewModel is often marked as:

* @ObservableObject
* @Published
* Or using @StateObject, @ObservedObject, etc.

```
View <--> ViewModel <--> Model
```

* View listens to ViewModel for state changes.
* ViewModel updates Model, performs logic (like network calls), and exposes clean data for the View.
* View sends user actions to the ViewModel.

Reference: https://www.youtube.com/watch?v=xB6uf_Aqq9g&t=9797s
Source Code: https://github.com/gahntpo/GhibliSwiftUIApp

| Type / Construct     |                                                                    What It Is |    Value or Reference? |                                                      Mutable? |                            Supports Inheritance? | When to Use                                                   | Quick Example                                               |
| -------------------- | ----------------------------------------------------------------------------: | ---------------------: | ------------------------------------------------------------: | -----------------------------------------------: | ------------------------------------------------------------- | ----------------------------------------------------------- |
| **struct**           |                                      Value-type container for data + behavior |         Value (copied) |                                              Mutable if `var` |                                                ❌ | Models, small data, SwiftUI views                             | `struct Point { var x: Int }`                               |
| **class**            |                                           Reference-type object with identity |     Reference (shared) |                                                 Yes (mutable) |                                               ✔️ | Shared state, UIKit, inheritance                              | `class VM { var x = 0 }`                                    |
| **enum**             |                                 Finite set of named cases (can hold payloads) |                  Value | Immutable cases; stored properties only via associated values |                                                ❌ | States, results, options                                      | `enum Mode { case light, dark }`                            |
| **enum (case-less)** |                                                  Namespace for static members |                    N/A |                                                           N/A |                                                ❌ | Grouping constants                                            | `enum Keys { static let k = "k" }`                          |
| **protocol**         |                           Interface / contract (method/property requirements) | N/A (not instantiable) |                                                           N/A |                                              N/A | Abstraction, DI, mocking                                      | `protocol P { func doIt() }`                                |
| **actor**            |                         Reference type with serialized (one-at-a-time) access |   Reference (isolated) |                                              Yes (serialized) |                                                ❌ | Shared mutable state in concurrency                           | `actor Store { var items = [Int]() }`                       |
| **tuple**            |                                                      Anonymous grouped values |                  Value |                                                           Yes |                                                ❌ | Quick returns, small bundles                                  | `(id: 1, name: "A")`                                        |
| **typealias**        |                                                              Rename of a type |                    N/A |                                                           N/A |                                              N/A | Improve readability                                           | `typealias Completion = () -> Void`                         |
| **extension**        | Adds functionality to an existing type (methods, computed props, conformance) |                    N/A |                                                           N/A | N/A (can extend classes/structs/enums/protocols) | Organize code, retroactively add methods/protocol conformance | `extension String { func isCapitalized() -> Bool { ... } }` |
