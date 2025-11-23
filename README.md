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
