let lexbuf = Lexing.from_channel stdin 

let ast = Parser.document Lexer.main lexbuf 

let _ = Printf.printf "Parse:\n%s\n" (Ast.document_string ast)

