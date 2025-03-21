open State
open Eval
open Printf

let execfile filename =
  try
    let ic = open_in filename in
    try
      while true do
        let tokens = String.split_on_char ' ' (input_line ic) in
        eval (create_state ()) tokens
      done
    with End_of_file -> close_in ic
  with Sys_error _ -> Printf.printf "Error: Could not open file: %s\n" filename

let repl () =
  let st = create_state () in
  print_endline "Forth REPL. Type 'exit' to quit.";
  try
    while true do
      print_string " ! "; flush stdout;
      let line = read_line () in
      if line = "exit" then exit 0;
      eval st (String.split_on_char ' ' line)
    done
  with End_of_file -> ()

let () =
  let args = Array.to_list Sys.argv in
  match args with
  | [] | [_] -> repl ()
  | _ :: filename :: _ -> execfile filename
