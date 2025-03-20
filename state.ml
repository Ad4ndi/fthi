open Hashtbl

type state = {
  mutable stack: int list;
  words: (string, string list) Hashtbl.t;
  memory: (int, int) Hashtbl.t;
  mutable mem_addr: int;
}

let create_state () = { 
  stack = []; 
  words = Hashtbl.create 10;
  memory = Hashtbl.create 10;
  mem_addr = 0;
}

let push st v = st.stack <- v :: st.stack

let pop st = 
  match st.stack with
  | [] -> print_endline "Error: Stack underflow"; None
  | x :: xs -> st.stack <- xs; Some x

let pop2 st =
  match st.stack with
  | x :: y :: xs -> st.stack <- xs; Some (y, x)
  | _ -> print_endline "Error: Stack underflow"; None

let pop3 st =
  match st.stack with
  | x :: y :: z :: xs -> st.stack <- xs; Some (z, y, x)
  | _ -> print_endline "Error: Stack underflow"; None

let get_memory st addr = Hashtbl.find_opt st.memory addr
let set_memory st addr v = Hashtbl.replace st.memory addr v
let get_words st = st.words
let next_mem_addr st = st.mem_addr <- st.mem_addr + 1
let get_mem_addr st = st.mem_addr
