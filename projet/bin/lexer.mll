{
  open Parser
}

let mot = [^'*' '#' '\\' '{' '}' '[' ']' '(' ')' ' ' '\n' '\t']+
let espace = [' ' '\t']
let newline = ('\n' espace* '\n')+
let c_digit = ['0'-'9' 'A'-'F' 'a'-'f']
let couleur = c_digit c_digit c_digit c_digit c_digit c_digit

rule main = parse
  | espace+                 { Printf.printf "1"; MOT (" ") }
  | newline                 { Printf.printf "2"; NEWLINE }
  | '\n'                    { Printf.printf "3"; main lexbuf }
  | "#" espace*             { Printf.printf "4"; TITRE1 }
  | "##" espace*            { Printf.printf "5"; TITRE2 }
  | "\\item" espace+        { Printf.printf "6"; ITEM }
  | "\\color"               { Printf.printf "f"; COULEUR }
  | couleur                 { Printf.printf "g"; MOT (Lexing.lexeme lexbuf) }
  | "**"                    { Printf.printf "7"; GRAS }
  | "*"                     { Printf.printf "8"; ITALIQUE }
  | "["                     { Printf.printf "9"; LBRACKET }
  | "]"                     { Printf.printf "a"; RBRACKET }
  | "{"                     { Printf.printf "h"; LBRACE }
  | "}"                     { Printf.printf "g"; RBRACE }
  | "("                     { Printf.printf "b"; LPAREN }
  | ")"                     { Printf.printf "c"; RPAREN }
  | mot                     { Printf.printf "d"; MOT (Lexing.lexeme lexbuf) }
  | eof                     { Printf.printf "e"; EOF }
  | _                       { failwith ("unexpected character: '" ^ Lexing.lexeme lexbuf ^ "'") } 