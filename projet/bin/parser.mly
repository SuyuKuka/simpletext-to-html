%{
open Ast
%}

%token NEWLINE TITLE1 TITLE2 ITEM ITALIC BOLD LBRACKET RBRACKET LPAREN RPAREN EOF
%token <string> WORD

%start <Ast.document> document

%%

document:
  c=corps EOF { c }

corps:
  | e=element NEWLINE c=corps { e :: c }
  | e=element { [e] }

element:
  | TITLE1 t=texte { Titre1 t }
  | TITLE2 t=texte { Titre2 t }
  | t=texte { Paragraphe t }
  | items=suite_items { Liste items }

suite_items:
  | i=item suite_items { i :: $2 }
  | i=item { [i] }

item:
  | ITEM t=texte { t }

texte:
  | e=element_de_texte t=texte { e :: t }
  | { [] }

element_de_texte:
  | w=WORD { Mot w }
  | ITALIC l=liste_mots ITALIC { Italique l }
  | BOLD l=liste_mots BOLD { Gras l }
  | LBRACKET l=liste_mots RBRACKET LPAREN w=WORD RPAREN { Lien (l, w) }

liste_mots:
  | w=WORD l=liste_mots { w :: l }
  | { [] }
