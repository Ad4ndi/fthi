open State

let rec eval st tokens =
  match tokens with
  | [] -> ()
  | ":" :: name :: body ->
      let rec get_body acc = function
        | ";" :: rest -> List.rev acc, rest
        | [] -> failwith "Missing ';'"
        | x :: xs -> get_body (x :: acc) xs
      in
      let body_code, rest = get_body [] body in
      Hashtbl.add (get_words st) name body_code;
      eval st rest
  | word :: rest ->
      (match Hashtbl.find_opt (get_words st) word with
      | Some body -> eval st (body @ rest)
      | None -> match word with
          | "+" -> (match pop2 st with Some (a, b) -> push st (a + b) | None -> ())
          | "-" -> (match pop2 st with Some (a, b) -> push st (a - b) | None -> ())
          | "*" -> (match pop2 st with Some (a, b) -> push st (a * b) | None -> ())
          | "/" -> (match pop2 st with Some (a, 0) -> print_endline "Error: Division by zero"
                    | Some (a, b) -> push st (a / b)
                    | None -> ())
          | "." -> (match pop st with Some x -> print_int x; print_newline () | None -> ())
          | "dup" -> (match st.stack with x :: _ -> push st x | [] -> print_endline "Error: Stack underflow")
          | "swap" -> (match pop2 st with Some (a, b) -> push st a; push st b | None -> ())
          | "over" -> (match st.stack with x :: y :: _ -> push st y | _ -> print_endline "Error: Stack underflow")
          | "rot" -> (match pop3 st with Some (a, b, c) -> push st b; push st c; push st a | None -> ())
          | "drop" -> ignore (pop st)
          | "@" -> (match pop st with 
                    | Some addr -> (match get_memory st addr with 
                                | Some v -> push st v
                                | None -> print_endline "Error: Invalid memory address")
                    | None -> ())
          | "!" -> (match pop2 st with Some (addr, v) -> set_memory st addr v | None -> ())
          | "," -> push st (get_mem_addr st); next_mem_addr st
          | "words" -> Hashtbl.iter (fun k _ -> print_endline k) (get_words st)
          | _ -> (try push st (int_of_string word) with Failure _ -> print_endline ("Unknown word: " ^ word))
      );
      eval st rest
