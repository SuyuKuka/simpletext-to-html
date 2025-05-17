let () =
  try
    let lexbuf = Lexing.from_channel stdin in
    let (macros, corps) = Parser.document Lexer.main lexbuf in
    let file = "out.html" in
    let message = Ast.document_string macros corps in
    let output = open_out file in
    Printf.fprintf output "%s\n" message;
    close_out output;
    Printf.printf "Parse:\n%s\n" message
  with
  | Failure msg -> Printf.eprintf "Erreur: %s\n" msg