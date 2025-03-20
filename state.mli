type state = {
  mutable stack: int list;
  words: (string, string list) Hashtbl.t;
  memory: (int, int) Hashtbl.t;
  mutable mem_addr: int;
}

val create_state : unit -> state
val push : state -> int -> unit
val pop : state -> int option
val pop2 : state -> (int * int) option
val pop3 : state -> (int * int * int) option
val get_memory : state -> int -> int option
val set_memory : state -> int -> int -> unit
val get_words : state -> (string, string list) Hashtbl.t
val next_mem_addr : state -> unit
val get_mem_addr : state -> int
