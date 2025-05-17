{
  open Parser
}

let mot = [^'*' '#' '\\' '{' '}' '[' ']' '(' ')' ' ' '\r' '\n' '\t']+
let espace = [' ' '\t']
let newline = espace* '\r'? '\n' espace*
let c_digit = ['0'-'9' 'A'-'F' 'a'-'f']
let couleur = c_digit c_digit c_digit c_digit c_digit c_digit
let nom = ['a'-'z' 'A'-'Z']+

rule main = parse
  | espace+                 { Printf.printf "SKIP ESPACE\n"; main lexbuf }
  | newline newline+        { Printf.printf "NEWLINE\n"; NEWLINE }
  | '\r'? '\n'              { Printf.printf "SKIP \\n\n"; main lexbuf }
  | "#"                     { Printf.printf "TITRE1\n"; TITRE1 }
  | "##"                    { Printf.printf "TITRE2\n"; TITRE2 }
  | "\\item"                { Printf.printf "ITEM\n"; ITEM }
  | "\\color"               { Printf.printf "COLEUR\n"; COULEUR }
  | couleur                 { Printf.printf "CODE COULEUR\n"; MOT (Lexing.lexeme lexbuf) }
  | "***"                   { Printf.printf "GRAS ET ITALIQUE\n"; GRASITALIQUE }
  | "**"                    { Printf.printf "GRAS\n"; GRAS }
  | "*"                     { Printf.printf "ITALIQUE\n"; ITALIQUE }
  | "["                     { Printf.printf "CROCHET G\n"; LBRACKET }
  | "]"                     { Printf.printf "CROCHET D\n"; RBRACKET }
  | "{"                     { Printf.printf "ACCOLADE G\n"; LBRACE }
  | "}"                     { Printf.printf "ACCOLADE D\n"; RBRACE }
  | "("                     { Printf.printf "PAREN G\n"; LPAREN }
  | ")"                     { Printf.printf "PAREN D\n"; RPAREN }
  | mot                     { let s = Lexing.lexeme lexbuf in
                              Printf.printf "MOT: '%s'\n" s;
                              MOT s }
  | "\\define"              { Printf.printf "DEFINE\n"; DEFINE }
  | "\\begindocument"       { Printf.printf "BEGIN DOCUMENT\n"; BEGINDOCUMENT }
  | "\\enddocument"         { Printf.printf "END DOCUMENT\n"; ENDDOCUMENT }
  | "\\" nom                { let s = Lexing.lexeme lexbuf in
                              Printf.printf "NOM: '%s'\n" s;
                              NOM s }
  | eof                     { Printf.printf "EOF\n"; EOF }
  | _                       { failwith ("unexpected character: '" ^ Lexing.lexeme lexbuf ^ "'") }