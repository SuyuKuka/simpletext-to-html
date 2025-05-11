%{
open Ast
%}

%token NEWLINE EOF
%token TITRE1 TITRE2 GRAS ITALIQUE GRASITALIQUE
%token ITEM COULEUR
%token LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN
%token<string> MOT
%token DEFINE BEGINDOCUMENT ENDDOCUMENT
%token<string> NOM

%start <Ast.document> document

%%

document:
  | c=corps EOF { ([], c) }
  | li=liste_macros BEGINDOCUMENT c=corps ENDDOCUMENT EOF { (li, c) } 

// Macros

liste_macros:
  li=list(macros) { li }

macros:
  DEFINE LBRACE i=identifiant RBRACE LBRACE t=texte RBRACE { (i, t) }

identifiant: n=nom { n }

nom: n=NOM { n }

// Corps 

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
  | ft=forme_texte { ft }
  | LBRACKET ft=forme_texte RBRACKET LPAREN m=mot RPAREN { Lien (ft, m) }
  | COULEUR LBRACE m=mot RBRACE LBRACE ft=forme_texte RBRACE { Couleur (m, ft) }
  | i=identifiant { Macro i }

forme_texte:
  | GRASITALIQUE ml=liste_mots GRASITALIQUE { GrasItalique ml }
  | GRAS ml=liste_mots GRAS { Gras ml }
  | ITALIQUE ml=liste_mots ITALIQUE { Italique ml }

liste_mots:
  l=list(mot) { l }

mot:
  m=MOT { m }