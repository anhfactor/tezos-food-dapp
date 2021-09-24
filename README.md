# Smart contract to buy food

### This Smart Contract Is Used For Testing Purposes
### Smart contract featues
- Made using cameLIGO
- A Smart contract use to order food
- Some food can't be bought if not_sale = true
- Add discount percent on food based on sale_off variable

View contract using Better Call Dev!  
https://better-call.dev/granadanet/KT1MTR7FX8mtav5moQXiR5aNQmFj8FJ6BnDf

The address of your contract is: 
```
KT1MTR7FX8mtav5moQXiR5aNQmFj8FJ6BnDf
```

The initial storage of contract is:
```
[ { "prim": "Elt", "args": [ { "int": "0" }, { "prim": "Pair", "args": [ { "prim": "Pair", "args": [ { "prim": "Pair", "args": [ { "string": "KT19hXKZjvg7KqQw78qfsbTQzZ5FMbNvkt7v" }, { "int": "5" } ] }, { "string": "Desert" }, { "string": "Dark sweet fresh chocolate" } ] }, { "prim": "Pair", "args": [ { "string": "Chocolate" }, { "int": "2" } ] }, { "prim": "True" }, { "int": "10" } ] } ] }, { "prim": "Elt", "args": [ { "int": "1" }, { "prim": "Pair", "args": [ { "prim": "Pair", "args": [ { "prim": "Pair", "args": [ { "string": "KT1QhzsrJkRmvEVEie45EPhMp5KY2nbGwKG2" }, { "int": "15" } ] }, { "string": "Sea food" }, { "string": "Vinegared rice seafood and vegetables" } ] }, { "prim": "Pair", "args": [ { "string": "Sushi Plate" }, { "int": "1" } ] }, { "prim": "False" }, { "int": "20" } ] } ] } ]
```
### Storage
Example: 
```
Map.literal [ 
  (0n, { 
    food_available = 5n ; 
    food_address = ("KT19hXKZjvg7KqQw78qfsbTQzZ5FMbNvkt7v" : address); 
    food_price = 2mutez ; 
    not_sale = true ; 
    food_name = "Chocolate" ;
    food_category = "Desert" ;
    food_description = "Dark sweet fresh chocolate" ;
    sale_off = 10n ;

  }); 
  (1n, { 
    food_available = 15n; 
    food_address = ("KT1QhzsrJkRmvEVEie45EPhMp5KY2nbGwKG2" : address); 
    food_price = 1mutez ;
    not_sale = false ; 
    food_name = "Sushi Plate" ;
    food_category = "Sea food" ;
    food_description = "Vinegared rice seafood and vegetables" ;
    sale_off = 20n ;
  })
]
```
