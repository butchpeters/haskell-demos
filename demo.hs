-- What is a functional programming language?

-- About Haskell

-- https://github.com/Dobiasd/articles/blob/master/programming_language_learning_curves.md

-- http://learnyouahaskell.com

-- Launch ghci
-- > :l demo.hs

-- Import modules at the top of a file
import Data.Char
import Data.List




------------------------------
-- FUNCTION BASICS
------------------------------

-- We can define a function
greeting name = "Hello, " ++ name

-- Where's the return statement?
-- I thought this was a statically typed language...
-- We can get the type of the function in ghci
-- > :t greeting
-- greeting :: [Char] -> [Char] reads (from left-to-right): function named 'greeting' takes a [Char] as a parameter and returns a [Char]





-- By convention, we should define the type of the function, even when it can be inferred
greeting' :: [Char] -> [Char]
greeting' name = "Hello, " ++ name






-- ++ looks like an operator, but it is a function too.  It's an infix function

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



















-------------------------------------------
-- PATTERN MATCHING, GUARDS and RECURSION
-------------------------------------------

-- We can destructure function parameters that are constructed with other values with pattern matching
head' :: [a] -> a
head' (x:xs) = x

fst' :: (a, b) -> a
fst' (a, _) = a

prettyName :: ([Char], [Char]) -> [Char]
prettyName (first, last) = first ++ " " ++ last

-- A pattern can be any type constructor, but not an expression (see guards)
-- You use specific values, variables or _ to match, bind or not bind the destructured values from the input value 






-- We can define multiple patterns for a single function, but they all need to have the same type signature
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty (x:xs) = False








-- Patterns are evaluated from top-to-bottom, using the first match it finds
isSeven :: (Num a, Eq a) => a -> Bool
isSeven 7 = True
isSeven _ = False









-- It's possible to have non-exhaustive patterns, in which case a runtime error can occur
isEight :: (Num a, Eq a) => a -> Bool
isEight 8 = True
isEight 7 = False









-- If we want to match a function based on an expression, we could use guards
howBigIsMyList :: [a] -> [Char]
howBigIsMyList xs
	| length xs == 0 = "What List?"
	| length xs < 10 = "Not so big"
	| otherwise = "Pretty big"








-- We can set up recursion using pattern matching and/or guards
maximum' :: (Ord a) => [a] -> a  
maximum' [] = error "maximum of empty list"  
maximum' [x] = x  
maximum' (x:xs)   
    | x > maximum' xs = x  
    | otherwise = maximum' xs















------------------------------------
-- PARTIAL FUNCTIONS
------------------------------------

-- Every function officially takes one parameter
-- Any function that takes more than one parameter can take less parameters and return a partially applied function
atLeastTen :: (Ord a, Num a) => a -> a
atLeastTen = max 10








-- Functions that take more than one parameter are said to be curried
atLeastTen' :: (Ord a, Num a) => a -> a
atLeastTen' x = ((max 10) x) 














-----------------------------------
-- HIGHER ORDER FUNCTIONS
-----------------------------------

-- We can use map to apply a function to every element in a list and return a new list
doubleMe :: Num a => [a] -> [a]
doubleMe xs = map (*2) xs








-- We can reduce this due to partial functions
doubleMe' :: Num a => [a] -> [a]
doubleMe' = map (*2)









-- We can use foldl with an anonymous function to reduce a list to a single value	
add :: (Num a) => [a] -> a
add xs = foldl (\acc x -> acc + x) 0 xs









-- foldl1 works just like foldl, except the acc initializes to the first element in the list
maximum'' :: (Num a, Ord a) => [a] -> a
maximum'' xs = foldl1 (\acc x -> max acc x) xs 










--------------------------------
-- PAREN HELPERS
--------------------------------

-- $: function application.  Evaluates everything to the right and passes it as a parameter to the left
howManyLessThanTen :: (Num a, Ord a) => [a] -> Int
howManyLessThanTen xs = length (filter (< 10) xs)

howManyLessThanTen' :: (Num a, Ord a) => [a] -> Int
howManyLessThanTen' xs = length $ filter (< 10) xs








-- dot (.): function composition.  Evaluates the rightmost function then passes the result to the next rightmost
filterBigWords :: [Char] -> [Char]
filterBigWords str = (unwords (filter (\w -> length w < 5) (words str)))

filterBigWords' :: [Char] -> [Char]
filterBigWords' = unwords . filter (\w -> length w < 5) . words












-----------------------
-- DEFINING TYPES
-----------------------

-- We can make our own data type
data Fruit = Orange | Apple | Strawberry






-- Then we can use it in a function
priceOfFruit :: Fruit -> Float
priceOfFruit Orange = 1.00
priceOfFruit Apple = 0.75
priceOfFruit Strawberry = 0.10







-- But we can't do anything useful with the fruit values themselves
-- > Orange
-- > Orange == Apple

-- We can make our type an instance of the appropriate type class.  For the standard type classes, we can use deriving
data Fruit' = Orange' | Apple' | Strawberry' deriving (Show, Eq)








-- For non-standard type classes (or if we want to make a custom implementation of a standard type class) we use instance
data Soda = Grape | Grapefruit deriving (Eq)

instance Show Soda where 
    show Grape = "This is purple."
    show Grapefruit = "Why isn't this purple? -50 cent" -- https://www.youtube.com/watch?v=waCF81HdKAA







-- Going back to our priceOfFruit function, wouldn't it be nice if we could write a generic price function?
class Purchaseable a where
    price :: a -> Float






-- Now we can create instances of the Purchaseable type class for our different items in the store
instance Purchaseable Fruit where
    price = priceOfFruit

instance Purchaseable Soda where
    price Grape = 0.55
    price Grapefruit = 0.50 -- see what I did there?







-- Value constructors for types can take parameters like a function
data Box = SquareBox Int | RectangleBox Int Int deriving (Show, Eq)


-- Try making some boxes
-- > SquareBox 5
-- > RectangleBox 6 10




-- We can use parameter destructuring to use values of this type in a function
boxArea :: Box -> Int
boxArea (SquareBox l) = l * l
boxArea (RectangleBox l w) = l * w










-- Types can have parameters, similar to value constructors
-- > :info Maybe

-- The Maybe type is used to express the 'null' concept in Haskell.
-- For example, the find function searches for a value in a list. What if it can't find the value?
-- > :t find
-- > find (> 4) [3, 5, 2, 6]
-- > find (> 6) [3, 5, 2, 6]










-- There is also a record syntax for more complex value structures
data Employee = Worker {firstName :: String, lastName :: String, employeeId :: Int} deriving (Show, Eq)

-- This automatically creates accessor functions for the fields
-- > firstName Worker {firstName = "Butch", lastName = "Peters", employeeId = 1}










---------------------
-- I/O
---------------------

-- I/O is problematic for a purely functional language
-- A function to get user input is not referentially transparent: it does not always return the same value
-- A function that writes a string to the console has a side effect: the state of the screen changes

-- We can control this impurity within a do-block.  The entire do-block evaluates to an IO action
doToUpper :: IO ()
doToUpper = do 
    contents <- getContents
    putStrLn (map toUpper contents)







-- Now that we can interact with the user, let's compile this.  Just like a C application, we need a main function.
-- main requires an IO action return type, so we'll call our doToUpper function directly
main :: IO ()
main = doToUpper




-- You can run the program with either the runhaskell interpreter, or compile it with ghc
-- $ runhaskell demo.hs 
-- $ ghc demo.hs