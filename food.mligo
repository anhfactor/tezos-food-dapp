//the useed types in the contract
type food_supply = { 
  food_address : address ; 
  food_available : nat ;  
  food_price : tez ; 
  not_sale : bool ; 
  food_name : string ;
  food_description: string ;
  food_category: string ;
  sale_off : nat;
}

type food_storage = (nat, food_supply) map
type return = operation list * food_storage
type food_id = nat

//types that are required for food transfer function 
type transfer_destination =
[@layout:comb]
{
  to_ : address;
  food_id : food_id;
  amount : nat;
}
 
type transfer =
[@layout:comb]
{
  from_ : address;
  txs : transfer_destination list;
}

//address to recieve money from food sales
let shop_address : address = ("tz1hZLzAq6RsPgHdBNmawjqb6sv9XRNmmuw4" : address)

// main function
let main (food_index, food_storage : nat * food_storage) : return =
    //checks if the food exist
  let food_kind : food_supply =
    match Map.find_opt (food_index) food_storage with
    | Some k -> k
    | None -> (failwith "Sorry, We the requested food is not available!" : food_supply)
  in

  // Check if the food is on sale  
  let () = if food_kind.not_sale = true then
    failwith "Sorry, This food is non-sale!"
  in

  // Check if offer is enough to cover price of food and subtract with sale off
  let () = if Tezos.amount < (food_kind.food_price - food_kind.food_price * food_kind.sale_off / 100n ) then
    failwith "Sorry, You need to pay more on this food!"
  in

 // Check if the food is available.
  let () = if food_kind.food_available = 0n then
    failwith "Sorry, we dont have any available of this food."
  in

 //Update our `food_storage` available.
  let food_storage = Map.update
    food_index
    (Some { food_kind with food_available = abs (food_kind.food_available - 1n) })
    food_storage
  in

  let tr : transfer = {
    from_ = Tezos.self_address;
    txs = [ {
      to_ = Tezos.sender;
      food_id = abs (food_kind.food_available - 1n);
      amount = 1n;
    } ];
  } 
  in

  // Transfer FA2 functionality
  let entrypoint : transfer list contract = 
    match ( Tezos.get_entrypoint_opt "%transfer" food_kind.food_address : transfer list contract option ) with
    | None -> ( failwith "Invalid external token contract" : transfer list contract )
    | Some e -> e
  in
 
  let fa2_operation : operation =
    Tezos.transaction [tr] 0tez entrypoint
  in

  // Payout to the shop address.
  let receiver : unit contract =
    match (Tezos.get_contract_opt shop_address : unit contract option) with
    | Some (contract) -> contract
    | None -> (failwith ("Not a contract") : (unit contract))
  in
 
  let payout_operation : operation = 
    Tezos.transaction unit amount receiver 
  in

 ([fa2_operation ; payout_operation], food_storage)