%{
open Ast
%}

%token NEWLINE EOF
%token TITRE1 TITRE2 GRAS ITALIQUE
%token ITEM COULEUR
%token LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
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
  | ITEM LBRACE e=element RBRACE { ItemImbrique e }

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
  | COULEUR LBRACE m=mot RBRACE LBRACE l=list(mot) RBRACE { Couleur (m, l) }

mot:m=MOT { m }
