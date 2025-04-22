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

suite_items:
  | i=item il=suite_items { i :: il }
  | i=item { [i] }

item:
  | ITEM t=texte { Item t }
  | ITEM LBRACE iml=separated_nonempty_list(NEWLINE, item_imbrique) RBRACE { ItemImbrique iml }

item_imbrique:
  | t=texte { ParagrapheImbrique t }
  | si=suite_items { SuiteItemsImbrique si }

texte:
  | elt=list(element_de_texte) { elt }

element_de_texte:
  | m=mot { Mot m }
  | GRAS l=liste_mots GRAS { Gras l }
  | ITALIQUE l=liste_mots ITALIQUE { Italique l }
  | LBRACKET l=liste_mots RBRACKET LPAREN m=mot RPAREN { Lien (l, m) }
  | COULEUR LBRACE m=mot RBRACE LBRACE l=liste_mots RBRACE { Couleur (m, l) }

liste_mots:
  l=list(mot) { l }

mot:
  m=MOT { m }