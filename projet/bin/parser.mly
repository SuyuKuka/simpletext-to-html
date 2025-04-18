%{
open Ast
%}

%token NEWLINE TITRE1 TITRE2 ITEM GRAS ITALIQUE LBRACKET RBRACKET LPAREN RPAREN EOF
%token<string> MOT

%start <Ast.document> document

%%

document:
  c=corps EOF { c }

corps:
  el=separated_nonempty_list(NEWLINE, element) { el }

element:
  | TITRE1 t=texte { Titre1 t }
  | TITRE2 t=texte { Titre2 t }
  | t=texte { Paragraphe t }
  | si=suite_items  { SuiteItems si }

suite_items:
  | i=item il=suite_items { i :: il }
  | i=item { [i] }

item:
  ITEM t=texte { t }

texte:
  elt=list(element_de_texte) { elt }

element_de_texte:
  | m=mot { Mot m }
  | GRAS l=list(mot) GRAS { Gras l }
  | ITALIQUE l=list(mot) ITALIQUE { Italique l }
  | LBRACKET l=list(mot) RBRACKET LPAREN m=mot RPAREN { Lien (l, m) }

mot:
  | m=MOT { " " ^ m  }
  // | ESPACE { " " }
