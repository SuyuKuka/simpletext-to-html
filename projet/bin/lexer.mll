{
  open Parser
}

let mot = [^'*' '#' '\\' '[' ']' '(' ')' ' ' '\n' '\t']+
let espace = [' ' '\t']
let newline = ('\n' espace* '\n')+


rule main = parse
  | espace+                { main lexbuf }
  | newline                 { NEWLINE }
  | '\n'                    { main lexbuf }
  | "#" espace*            { TITRE1 }
  | "##" espace*           { TITRE2 }
  | "\\item" espace+       { ITEM }
  | "**"                  { GRAS }
  | "*"                   { ITALIQUE }
  | "["                   { LBRACKET }
  | "]"                   { RBRACKET }
  | "("                   { LPAREN }
  | ")"                   { RPAREN }
  | mot                   { MOT (Lexing.lexeme lexbuf) }
  | eof                   { EOF }
  | _                     { failwith ("unexpected character: '" ^ Lexing.lexeme lexbuf ^ "'") }