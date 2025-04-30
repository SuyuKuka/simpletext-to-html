let lexbuf = Lexing.from_channel stdin 

let (macros, corps) = Parser.document Lexer.main lexbuf
let file = "out.html"
let message = Ast.document_string macros corps

let _ = 
  let output = open_out file in
    Printf.fprintf output "%s\n" message;
    close_out output;
  Printf.printf "Parse:\n%s\n" message
