# Swift Programming Language

## Auto Layout
- **stack view**: group items (ex: buttons) in storyboard together either horizontally OR vertically
  - stacks can be stacked together (a group of horizontal stacks stacked vertically)
  - "stick" objects to the edges so that they remain proportional on different devices
  - "pin" objects by doing ctrl + drag to a side and then "__ Space to Safe Area"
  - create **constraints** relative to other objects by doing "Vertical Spacing" (ex)
    - "greater than or equal" vs "equal" spacing

## Range
- Floating point CountableRange
  - use global function **stride**
    - ex) for i in stride(from: 0.5, to: 15.25, by: 0.3)
      - returns a CountableRange
    - ex) for i in stride(from: 0.5, through: 15.25, by: 0.3)
      - returns a ClosedCountableRange

## Tuples
- grouping of values
- good for returning multiple values from a function or method
- indexing not supported
- ex) let x: (String, Int, Double) = ("hello", 5, 0.8)
  - let (word, number, value) = x -> names tuple elements when accessing it
  - print(word) -> prints "hello"
- ex) let x: (w: String, i: Int, v: Double) = ("hello", 5, 0.8)
  - print(x.w) -> prints "hello"
  - preferred way of declaring a tuple
  - let (word, num, val) = x -> renames tuple's elements

## Computed Properties
- value can be computed rather than stored  
```
  var foo: Double {
    get {
      // calculations...
      // return calculated value of foo
    }
    set (newValue) {
      // do something based on the fact that foo has changed to newValue
    }
  }
```
  - set is optional
- useful when a "property" is derived from another object
  - ex: in Concentration, var indexOfOneAndOnlyFaceUpCard: Int? could have been...
```
  var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      // look at all cards and see if you find one that is face up
      // return that index or nil
    }
    set {
      // turn all cards face down except at index newValue
    }
  }
```
  - don't need "set(newValue)" bc newValue already exists without stating it

## Access Control

- when projects get large, you want to be able to protect the INTERNAL implementation of data structures to prevent future errors
- mark which API (methods and properties) you want other code to use through certain keywords...
  - **internal**: default, accessible anywhere
  - **private**: only accessible within this object, nowhere else
  - **private(set)**: accessible outside of object, but not settable
  - **fileprivate**: accessible by any code in this specific file
  - public: (frameworks only), accessible to objects outside of frameworks
  - open: (frameworkds only), accessible anywhere, objects outside of framework can subclass this
- make everything private by default as good practice
- **assert** statements protect properties/methods from illegal input values

## Extensions

- extend existing data structures (add vars & functions to other classe/struct/enum even if you don't have the source)
- restrictions
  - can't have storage associated w them (must be computed properties only)
  - can only add new methods/properties, cant replace ones that already exist
- easily abused...
  - don't add a var/func to a class that doesn't need it
    - ex) don't add an extension to String that has to do with Concentration to simplify things in Concentration, since it doesn't improve the String class itself
  - should only be used to enhance & add readability to a class

## Enum

- data type with discrete values
```
  enum FastFoodMenuItem {
    case hamburger(patties: Int)
    case fries(size: FryOrderSize)
    case drink(String, oz: Int)
    case cookie
  }

  enum FryOrderSize {
    case large
    case small
  }
```
- value types (like structs, not classes)
- each case can have associated data/value (ex: look at fries)
- setting value:
```
  let menuItem: FastFodMenuItem = FastFoodMenuItem.hamburger(patties: 2)
  var otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
```
  - can infer type on ONE side of argument
```
  let menuItem = FastFodMenuItem.hamburger(patties: 2)
  var otherItem: FastFodMenuItem = .cookie
  // can't do var anotherItem = .cookie
```
- checking state using a switch statements (has to include every possible case)
```
  var menuItem = FastFodMenuItem.hamburger(patties: 2)
  switch menuItem {
    case .hamburger: print("burger")
    case .fries: break
    default: print("other")
  }
  // prints "burger"
```
    - **break** allows code to do nothing (if menuItem was .fries, then above code would print nothing)
    - **default** for every other case not explicitly stated
    - multiple lines within a case allowed (without {})
    - no fallthrough (unlike Java) so break statements aren't needed
- associated data accessed within switch statement using "let"
```
  var menuItem = FastFodMenuItem.drink("Coke", ounces: 32)
  switch menuItem {
    case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
    etc...
  }
  // prints "a 32oz Coke"
```
  - local variable retrieving associated data can have different name from the name used in enum declaration (ex: ounces vs oz, brand vs String)
- can have methods and computed properties, but can't have stored properties within declaration
```
  enum FastFodMenuItem {
    case...
    ...

    func isIncludedInSpecialOrder(number: Int) -> bool {}
    var calories: Int {//calculate & return a value here}
  }
```
- can test an enum's state within the enum iself using self
```
  enum FastFodMenuItem {
    ...
    func isIncludedInSpecialOrder(number: Int) -> Bool {
      switch self {
        case .hamburger(let pattyCount): return pattyCount == number
        case .fries, .cookie: return true
        case .drink(_, let ounces): return ounces == 16
      }
    }
  }
```
  - can combine 2 cases in switch statement (case .fries, .cookie:)
- can modify self within enum itself (have to put **mutating**, which is required bc enums are value types)
```
  enum FastFodMenuItem {
    ...
    mutating func switchToBeingACookie() {
      self = .cookie
    }
  }
```

## Optionals

- an enum!
```
  enum Optional<T> {
    case none
    case some(<T>)
  }
```
- special syntax
  - **nil** = "not set"
  - **?** declares Optional
    - ex: var indexOfOneAndOnlyFaceUpCard = Int?
  - **!** unwraps associated data if Optional is in set state (not nil)
  - **if** is used to conditionally get associated data
  - declaring with **!** instead of ? will implicitly unwrap value when accessed
  - **??** used in expression that defaults to a value if optional is nil
    - ex: return emoji[card.identifier] ?? "?"
- **Optional Chaining**: using **?** when accessing an optional to exit an expression midstream if it ever contains a nil value
```
  let x: String? = ...
  let y = x?.foo()?.bar?/z
  // if x or foo() or bar are nil, then we get nil for y
```

## Data structures

- 4 essential data structure-building concepts in Swift:
  - class, struct, enum, protocol
- **class**
  - single inheritance of functionality and data (ex: instance variables)
  - reference type (var x = object -> x is a POINTER to object)
    - lives in the heap, heap is cleaned up by Swift via **automatic reference counting**
      - counts references to each class; when there are no references, class gets tossed automatically
      - NOT garbage collection
      - influenced by keywords "strong", "weak", and "unowned"
        - **strong**: default, stays in heap as long as a pointer exists
        - **weak**: set to nil if unused by any strong pointers (therefore must be an Optional pointer to reference type)
          - ex: outlets
        - **unowned**: "don't reference count this, crash if I'm wrong"
          - rarely used, usually to break memory cycles between objects
- **struct**
  - value type (var x = object -> x has same value as object)
  - **mutating** methods must be marked w that keyword
  - no inheritance of data
  - mutability controlled via **let**
  - ex: Card, Array, Dictionary, Strict, Character, Int, etc
- **enum**: look above
- **protocol**
  - 
