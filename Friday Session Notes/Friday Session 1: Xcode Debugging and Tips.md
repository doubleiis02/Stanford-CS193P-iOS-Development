# Debugging and Xcode Tips and Tricks

## Key Commands and Shortcuts
- run project: **command + r**
- left pane: command + 0
  - top icons in left pane: command + 1, command + 2, command + 3 etc....
- right pane: command + option + 0
  - top icons in right pane: command + option + 1, command + option + 2 etc...
- add editor to right: command + control + T
- search for file to open in current editor: **command + shift + O**

## Tools Within the editor
- **//MARK**: establishes navigation points in your code
- **//TODO**: does the same as above but for todos
- comment out highlighted block of code: **command + /**
- fix indentation within block of code: **control + i**

## Debugger
- run crashes with error code -> go to top of error to see where the error occurred
- key value coding-compliant error -> storyboard element isn't properly connected to Controller (perhaps a naming issue)
- establish a break point by clicking on line number next to code -> creates a blue tag on number
  - put break points on the first line within a function usually
- **list of all break points**: left pane, tag icon
  - add new breakpoints by clicking on + at the bottom
  - **exception break point**: stops code when an exception occurs and opens debugger
  - can disable individual break points here
- **debugger area**: left side of bottom pane
  - activate/disable all break points by clicking on the tag icon at the top
  - shows info about all variables up to the break point when debugger is activated
  - **continue program execution icon**: currently stopped at a break point, continue running until the next break point or end of program
  - **step over icon**: move to next line of code
  - **step into icon**: move into the top of the method within the line
- output box on right of bottom pane
  - (lldb) stands for the debugger
  - typing **"po objectName"** prints out info about object
  - typing **"p objectName"** does print(objectName)

## Modifying Different Behaviors of Xcode
- go to preferences -> behavior and edit actions there
- customizable

## Within an Xcode Project
- build settings: shows things like what language the project uses
- build phases: shows all source files
  - link binary with libraries: shows libraries that you have added
