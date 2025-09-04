# Functions; can be executed with `terraform console` command
## Numeric ##
#############
abs(n) - Returns Absolute (Modulus) Value  of 'n'
### Example
> abs(-11.5)
11.5

ceil(n) - Returns Ceiling (rounding to next integer) of 'n'
### Example
> ceil(21.6)
22

floor(n) - Returns Floor (rounding to previous interger) of 'n'
### Example
> floor(21.6)
21

log(n, base) - Returns Logrithmic value of 'n' with 'base'
### Example
> log(2, 10)
0.30102999566398114
//This function is different from what was mentioned in LinkedIn Learning, 
//possibility of change with improvement

max(m, n, p, q, ...) - Returns Maximum Value from 'm', 'n', 'p', 'q', ....
### Example
> max(12, 5, -6, 8)
12

min(m, n, p, q, ...) - Returns Minimum Value

parseint("n", base) - Converts String "n" to Value of 'base' type 
    (base - Decimal(10), Hexadecimal (16), Binary(2) Octal (8))
### Example
> parseint("ff", 16) // Hexadecimal
255

pow(a,b) - Returns 'a' to Power 'b' (a^b)

signum(n) - Returns Sign of 'n' (1 for Positive, -1 for Negative, 0 for 0)


## String ##
############
chomp(str) - Removes Tailing NewLine Character from String 'str'
### Example
> chomp("Hello World\n")
"Hello World"
// Not Sure what is does with Multiple Lines?
/*
> chomp("Hello World \nSecond Line")
<<EOT
Hello World
Second Line
EOT
*/

startswith(str, st) - Checks if String 'str' starts with String 'st'
### Example
> startswith("Terraform", "Terra")
true
> startswith("Terrafrom", "terra")
false

endswith(str, st) - Checks if String 'str' ends with String 'st'
### Example 
> endswith("FirstString","ing")
true
> endswith("FirstString","string")
false

strcontains(str, st) - Checks is String 'str' contains substring 'st'

strrev(str) - Returns Reverse of String 'str'

substr(str, n, p) - Returns a Substring of 'str' of length 'p' offset from nth location (starts with 1)
### Example
> substr("This is a Test String to Print Things", 12, 8)
"st Strin"

format("... %s ...", str) - Fromats String based on Format Specifier (Replaces %s with String 'str' in this case)
### Example
> format("Hello, %s!","Terr")
"Hello, Terr!"
> format("%s!, \n %s", "First String Char", "SeccondExp")
<<EOT
First String Char!,
 SeccondExp
EOT
// Needs more Understanding and Experimenting

formatlist("... %s ...", [str1, str2, ...]) - Similar to format(), but creates List of Strings based on str1, str2, ...
### Example
> formatlist("Greetings, %s!", ["Tony","Steve","Bruce"])
tolist([
  "Greetings, Tony!",
  "Greetings, Steve!",
  "Greetings, Bruce!",
])

indent - Used to add Indent Space in an existing String
### Example
> "To Do List: ${indent(2, "Task A\nTaskB${indent(4, "\nTaskB-1\nTakB-2")}\nTaskC")}\nList-End"
<<EOT
To Do List: Task A
  TaskB
      TaskB-1
      TakB-2
  TaskC
List-End
EOT

join(str, list[a, b, c, ...]) - Joins the List of Elements with String 'str'
### Example
> join(", ",["Step1","Step2","Finish"])
"Step1, Step2, Finish"
> join(" -> ",["Step1","Step2","Finish"])
"Step1 -> Step2 -> Finish"

lower(str) - Converts String 'str' to lower case

upper(str) - Converts String 'str' to UPPER CASE

title(str) - Converts String 'str' to Title Case

regex(st, str) - Performs Regular Expression Matching and Returns first match of 'st' found in 'str'
> regex("[a-z]","ABBcdefg12345wwert")
"c"
> regex("[a-z]+", "ABBcdefg12345wwert")
"cdefg"
> regex("[0-9]+", "ABBcdefg12345wwert")
"12345"

regexall(st, str) - Returns all matches of regex() as a List
### Example
> regexall("[a-z]+", "ABBcdefg12345wwert")
tolist([
  "cdefg",
  "wwert",
])

replace(str, a, b) - Replaces occurane of 'a' with 'b' in String 'str'
### Exxample
> replace("Great Cook Peter!", "e", "~")
"Gr~at Cook P~t~r!"

split(delim, str) - Splits the String 'str' to a List based on the Delimiter 'delim'
### Example
> split("-", "FirstWord, TestFirst-SecondWord, Third-Forth-Fifth")
tolist([
  "FirstWord, TestFirst",
  "SecondWord, Third",
  "Forth",
  "Fifth",
])

trim(str, st) - Trims 'st' from Starting and Ending (if applicable) from 'str'
### Example
> trim("Sample String", "Sa")
"mple String"
> trim("WokoW", "W")
"oko"

trimprefix(str, st) - Trims only Starting 
> trimprefix("WokoW", "W")
"okoW"

trimsuffix(str, st) - Trims only Ending
> trimsuffix("WokoW", "W")
"Woko"

## Collections ##
#################

alltrue([m,n,p,...]) - Returns TRUE if m, n, p, ... is TRUE
### Example
> alltrue([true, true, true])
true
> alltrue([true, true, false])
false

anytrue(ls) - Returns TRUE if one of the Items from List 'ls' is TRUE

chunklist(ls, n) - Splits List 'ls' into chunks of size 'n'
### Example
>  chunklist([2,4,3,1,5,7],3)
tolist([                # [[2,4,3],[1,5,7]]
  tolist([              # [2,4,3]
    2,
    4,
    3,
  ]),
  tolist([              # [1,5,7]
    1,
    5,
    7,
  ]),
])
> chunklist([2,4,3,1,5,7,9],2)
tolist([                # [[2,4],[3,1],[5,7],[9,]]
  tolist([              # [2,4]
    2,
    4,
  ]),
  tolist([              # [3,1]
    3,
    1,
  ]),
  tolist([              # [5,7]
    5,
    7,
  ]),
  tolist([              # [9,]
    9,
  ]),
])

coalesce(m,n,p,...) - Returns first non-empty / non-Null String from the 'm', 'n', 'p', ...
### Example
> coalesce(null, "2ndItem", null, "4thItem")
"2ndItem"
// Maybe this function should be part of String Functions 

coalescelist(m, n, p, ...) - Retruns first non-empty List from the Lists 'm', 'n', 'p', ...
### Example
> coalescelist([],[],[3,4],[],[2,1])
[
  3,
  4,
]
// Cannot use colesce() function for the same case, Returns as Follows:
/*
> coalesce([],[],[3,4],[],[2,1])
tolist([])
*/

compact(ls) - Removes Null Items from the List 'ls' and Returns all the Remaining Elements
            - Converts Number Items to String in the Process
### Example 
> compact([3,null,1,null,5,7,2,null,8])
tolist([
  "3",
  "1",
  "5",
  "7",
  "2",
  "8",
])

concat(ls1, ls2, ...) - Combines the Lists 'ls1', 'ls2', ... and Retruns a single List of all Elements
                      - Doesn't modify the Type of Element in the List
### Example
> concat([2,4,3], ["A","B","D"], [7,4,2])
[
  2,
  4,
  3,
  "A",
  "B",
  "D",
  7,
  4,
  2,
]

contains(ls, e) - Checks if List 'ls' has Element 'e'
### Example
> contains(["Ironman", "Thor", "Hulk"], "CaptainAmerica")
false
> contains(["Ironman", "Thor", "Hulk"], "Hulk")
true

distinct(ls) - Removes duplicate items from the List 'ls'
### Example
> distinct([2,4,3,5,6,4,3,2,1,4,3,5,6,3,1])
tolist([
  2,
  4,
  3,
  5,
  6,
  1,
])

element(ls, n) - Retruns Element from Location 'n' from List 'ls' (Index from 0)
### Example
> element([3,5,8,22,45,6,11,32], 0)
3
> element([3,5,8,22,45,6,11,32], 4)
45

flatten(nls) - Flattens the Nested List 'nls'
### Example
> flatten([[3,4],[2,[5,7,9,[6,8]],12,7]])
[
  3,
  4,
  2,
  5,
  7,
  9,
  6,
  8,
  12,
  7,
]

index(ls, ele) - Returns the First occurane location of Element 'ele' in List 'ls' (Index from 0)
### Example
> element([3,5,8,4,3,8,1,7],7)
7
> element([3,5,8,4,3,8,1,7],8)
3

// Skipped Other Stuff and Told to Refer URL in the Video
