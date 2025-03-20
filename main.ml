open State
open Eval

let repl () =
  let st = create_state () in
  print_endline "Forth REPL. Type 'exit' to quit.";
  try
    while true do
      print_string " > ";
      flush stdout;
      let line = read_line () in
      if line = "exit" then (print_endline "Bye!"; exit 0);
      let tokens = String.split_on_char ' ' line in
      eval st tokens
    done
  with End_of_file -> print_endline "\nBye!"

let () = repl ()
