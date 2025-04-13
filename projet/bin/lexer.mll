{
  open Parser
}

let word = [^'*' '#' '\\' '[' ']' '(' ')' ' ' '\n' '\t']+
(* let word = [^'*' '#' '[' ']' '(' ')' ' ' '\t']+ *)
let space = [' ' '\t']+

rule main = parse
  | space                 { Printf.printf "Found space\n"; main lexbuf } 
  | "\n" space* "\n"      { Printf.printf "Found double newline\n"; NEWLINE }  
  | '\n'                  { Printf.printf "Found single newline\n"; main lexbuf } 
  | "##"                  { Printf.printf "Found title 2\n"; TITLE2 } 
  | "#"                   { Printf.printf "Found title 1\n"; TITLE1 } 
  | "\\item"              { Printf.printf "Found item\n"; ITEM }
  | "**"                  { Printf.printf "Found bold\n"; BOLD }
  | "*"                   { Printf.printf "Found italic\n"; ITALIC }
  | "["                   { Printf.printf "Found left bracket\n"; LBRACKET }
  | "]"                   { Printf.printf "Found right bracket\n"; RBRACKET } 
  | "("                   { Printf.printf "Found left parenthesis\n"; LPAREN }
  | ")"                   { Printf.printf "Found right parenthesis\n"; RPAREN }
  | word                  { Printf.printf "Found word: %s\n" (Lexing.lexeme lexbuf); WORD (Lexing.lexeme lexbuf) } 
  | eof                   { Printf.printf "Found EOF\n"; EOF }
  | _ as c                { Printf.eprintf "Unexpected character: %c\n" c; failwith "unexpected character" }
