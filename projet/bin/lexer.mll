{
  open Parser
}

let mot = [^'*' '#' '\\' '{' '}' '[' ']' '(' ')' ' ' '\n' '\t']+
let espace = [' ' '\t']
let newline = ('\n' espace* '\n')+
let c_digit = ['0'-'9' 'A'-'F' 'a'-'f']
let couleur = c_digit c_digit c_digit c_digit c_digit c_digit

rule main = parse
  | espace+                 { Printf.printf "a"; MOT (" ") }
  | newline                 { Printf.printf "b"; NEWLINE }
  | '\n'                    { Printf.printf "c"; main lexbuf }
  | "#" espace*             { Printf.printf "d"; TITRE1 }
  | "##" espace*            { Printf.printf "e"; TITRE2 }
  | "\\item" espace+        { Printf.printf "f"; ITEM }
  | "\\color"               { Printf.printf "g"; COULEUR }
  | couleur                 { Printf.printf "h"; MOT (Lexing.lexeme lexbuf) }
  | "**"                    { Printf.printf "i"; GRAS }
  | "*"                     { Printf.printf "j"; ITALIQUE }
  | "["                     { Printf.printf "k"; LBRACKET }
  | "]"                     { Printf.printf "l"; RBRACKET }
  | "{"                     { Printf.printf "m"; LBRACE }
  | "}"                     { Printf.printf "n"; RBRACE }
  | "("                     { Printf.printf "o"; LPAREN }
  | ")"                     { Printf.printf "p"; RPAREN }
  | mot                     { Printf.printf "q"; MOT (Lexing.lexeme lexbuf) }
  | eof                     { Printf.printf "r"; EOF }
  | _                       { failwith ("unexpected character: '" ^ Lexing.lexeme lexbuf ^ "'") } 