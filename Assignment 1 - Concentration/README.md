# CS193P Assignment 1 - Concentration

Match every pair by remembering where cards are located.  
Earn 2 points for every match. Lose one point for every mismatch involving a card you have already seen.  
There are 6 different themes of cards, which are randomly assigned to each new game  
[Directions] (https://applehosted.podcasts.apple.com/stanford/Programming_Project_1_Concentration.pdf)

## Notes

### Classes vs Structs
- CLASSES get a free init as long as all its properties are initialized
- structs have no inheritance
- structs are value types (pass the value), while classes are reference types (pass a reference)
- struct ex: var x = 1; var i = x (i = 1 but doesn't point to x)
- class ex: var x = 1; var i = x (i points to x)
- structs get one init that has parameters for ALL properties, regardless of whether they have already been initialized
- since Card is a struct, doing cards += [card, card] COPIES the contents into the array, so they don't reference the same card

### lazy
- lazy: doesn't get initialized immediately
- lazy vars cannot have a didSet (or any property observer)

### Connecting View to Controller
- to rename an IBOutlet or IBAction function, do command click rename so that buttons/labels are still connected to the renamed function

### Optionals
- optional binding: "if let constantName = optionalValue" means that if the optional isn't nil, then let constantName = optionalValue
- looking up anything in a dictionary returns an optional value
- emoji[card.identifier] ?? "?" is the same is doing...if emoji[card.identifier] != nil { return emoji[card.identifier]!} else {return "?"}

### Arrays and Range
- array.indices returns a countable range (if an array has 5 items then it returns 0...4)
- countable range #...#: goes through each int in range, inclusive at both ends
- countable range #..<#: goes through each int in range, exclusive of the upper bound
- shuffle contents in Array by doing array.shuffle()

### Random Int
- arc4random_uniform(upperBound) returns random number between 0 and upperbound where upperBound is not inclusive (ex: arc4random_uniform(Unit32(4)) returns 0, 1, 2, or 3)

### Declaring and Initializing
- var emoji = \[Int:String]() is the same as var emoji = Dictionary<Int, String>[]
- Swift has strong type inference, which means that var flipCount: Int = 0 is not necessary, instead write var flipCount = 0
- replace varaible name with underscore "_" whenever we won't be referencing that var

### Other
- two if's can be put on the same line if they are related (if ___ { if ___ {}} -> if ____, if ____ {})
- static methods can access static vars without the prefix "static"
- cards += [card, card] is the same as doing cards.append(card) twice


