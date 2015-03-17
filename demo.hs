-- Launch ghci
-- > :l demo.hs




------------------------------
-- FUNCTIONS
------------------------------

-- We can define a function
greeting name = "Hello, " ++ name

-- Where's the return statement?
-- I thought this was a strongly typed language...
-- We can get the type of the function in ghci
-- > :t greeting
-- greeting :: [Char] -> [Char] reads (from left-to-right): function named 'greeting' takes a [Char] as a parameter and returns a [Char]





-- By convention, we should define the type of the function, even when it can be inferred
greeting' :: [Char] -> [Char]
greeting' name = "Hello, " ++ name






-- ++ is a function too.  It's an infix function

-- We can call an infix function as a prefix function
greeting'' :: [Char] -> [Char]
greeting'' name = (++) "Hello, " name









-- We can define an infix function as long as it only contains special characters and takes exactly two arguments
(...) :: [Char] -> [Char] -> [Char]
first ... second = first ++ "..." ++ second

-- We can also define an infix function with alpha characters by using backticks
dotdotdot :: [Char] -> [Char] -> [Char]
first `dotdotdot` second = first ... second

-- ... but you can still call it with prefix style without backticks
-- > dotdotdot "Hello" "World"







-----------------------------
-- LISTS
-----------------------------

-- We can make a list
-- > [1,2,3,5,8]

-- Lists can only contain a single type of data

-- Lists can be empty
-- > []

-- Lists can define a range
-- > [1..10]

-- You can skip numbers in a range
-- > [1,3..20]

-- A list can be infinite
-- > [1..]

-- But you can set a finite limit with the take function
-- > take 20 [1,3..]

-- You can add an element to the head of a list with the cons operator
-- > 1:[2,3]

-- In fact, [1,2,3] is just syntactic sugar for 1:2:3:[]
-- > 1:2:3:[]

-- You can concatenate two lists together with ++
-- > [1] ++ [2,3]

















--------------------------
-- TUPLES
--------------------------

-- We can make a tuple of any length > 2.
-- > ("Butch", "Peters")

-- A tuple of length 1 is just the value itself
-- > ("Butch") == "Butch"

-- A tuple defines a kind-of dynamic type. ("Butch", 34) is a different type than (34, "Butch")

-- You can only pass in tuples of a given type to a function
-- > fst ("Butch", "Peters")
-- > fst ("Butch", "Peters", 34)

-- You can only make lists of tuples of the same type
-- > [("Butch", "Peters", 34), ("Cassie", "Peters")]
























---------------------------------------
-- TYPE VARIABLES and TYPE CLASSES
---------------------------------------

-- Some functions accept variable types
-- > :t head
-- > head [1,2,3]
-- > head ["Butch", "Chris", "DJ"]


-- Other functions accept variable types, but with a constraint called a type class
-- > :t (==)
-- > 1 == 1
-- > "Butch" == "Chris"

-- You can learn more about a type class with :info
-- > :info Eq
-- > :t (+)
-- > :info Num

-- What do type classes remind you of (from OO languages)?



















----------------------------
-- FUNCTIONS 102
----------------------------

-- Function parameters can be destructured with a concept called pattern matching
head' :: [a] -> a
head' (x:xs) = x

fst' :: (a, b) -> a
fst' (a, _) = a

prettyName :: ([Char], [Char]) -> [Char]
prettyName (first, last) = first ++ " " ++ last