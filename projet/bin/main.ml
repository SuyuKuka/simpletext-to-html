let lexbuf = Lexing.from_channel stdin 

let ast =
  try
    Parser.document Lexer.main lexbuf
  with
  | Ast.NotExistMacro id ->
      Printf.eprintf "Erreur: la macro '%s' n'existe pas.\n" id;
      exit 1
  | Ast.MacroAlreadyDefine id ->
      Printf.eprintf "Erreur: la macro '%s' déjà définie.\n" id;
      exit 1

let file = "out.html"
let message = Ast.document_string ast

let _ = 
  let output = open_out file in
    Printf.fprintf output "%s\n" message;
    close_out output;
  Printf.printf "Parse:\n%s\n" (Ast.document_string ast)
