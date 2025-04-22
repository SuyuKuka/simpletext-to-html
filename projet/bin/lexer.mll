{
  open Parser
}

let mot = [^'*' '#' '\\' '{' '}' '[' ']' '(' ')' ' ' '\n' '\t']+
let espace = [' ' '\t']
let newline = espace* '\n' espace*
let c_digit = ['0'-'9' 'A'-'F' 'a'-'f']
let couleur = c_digit c_digit c_digit c_digit c_digit c_digit

rule main = parse
  | espace+                 { Printf.printf "skip espace\n"; main lexbuf }
  | newline newline+        { Printf.printf "newline\n"; NEWLINE }
  | '\n'                    { Printf.printf "skip \\n\n"; main lexbuf }
  | "#"                     { Printf.printf "titre1\n"; TITRE1 }
  | "##"                    { Printf.printf "titre2\n"; TITRE2 }
  | "\\item"                { Printf.printf "\\item\n"; ITEM }
  | "\\color"               { Printf.printf "\\color\n"; COULEUR }
  | couleur                 { Printf.printf "code couleur\n"; MOT (Lexing.lexeme lexbuf) }
  | "**"                    { Printf.printf "GRAS\n"; GRAS }
  | "*"                     { Printf.printf "ITALIQUE\n"; ITALIQUE }
  | "["                     { Printf.printf "CROCHET G\n"; LBRACKET }
  | "]"                     { Printf.printf "CROCHET D\n"; RBRACKET }
  | "{"                     { Printf.printf "ACCOLADE G\n"; LBRACE }
  | "}"                     { Printf.printf "ACCOLADE D\n"; RBRACE }
  | "("                     { Printf.printf "PAREN G\n"; LPAREN }
  | ")"                     { Printf.printf "PAREN D\n"; RPAREN }
  | mot                     { let s = Lexing.lexeme lexbuf in
                              Printf.printf "mot: '%s'\n" s;
                              MOT s }
  | eof                     { Printf.printf "eof\n"; EOF }
  | _                       { failwith ("unexpected character: '" ^ Lexing.lexeme lexbuf ^ "'") } 