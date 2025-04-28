let lexbuf = Lexing.from_channel stdin 

let ast = Parser.document Lexer.main lexbuf 

let file = "out.html"
let message = Ast.document_string ast

let _ = 
  let output = open_out file in
    Printf.fprintf output "%s\n" message;
    close_out output;
  Printf.printf "Parse:\n%s\n" (Ast.document_string ast)
