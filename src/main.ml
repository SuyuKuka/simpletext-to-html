let () =
  let file = Sys.argv.(1) in
  let channel = open_in file in
  let lexbuf = Lexing.from_channel channel in
  try
    let ast = Parser.document Lexer.main lexbuf in
    print_endline "Parse successful!";
    print_endline (Ast.string_of_document ast);
    close_in channel
  with
  | Parsing.Parse_error ->
      let pos = lexbuf.Lexing.lex_curr_p in
      Printf.eprintf "Syntax error at line %d, column %d\n"
        pos.Lexing.pos_lnum (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
      exit 1
