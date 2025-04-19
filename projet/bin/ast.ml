(* Arbre *)
type mot = string

and element_de_texte =
  | Mot of mot
  | Italique of mot list
  | Gras of mot list
  | Lien of mot list * mot
  | Couleur of mot * mot list

and texte = element_de_texte list
      
and item = texte

and suite_items = item list

and element =
  | Titre1 of texte
  | Titre2 of texte
  | Paragraphe of texte
  | SuiteItems of suite_items

and corps = element list
    
and document = corps

(* Affichage *)
let rec liste_mots_string = function
  | [] -> ""
  | [last] -> last
  | hd :: tl -> hd ^ liste_mots_string tl
and element_de_texte_string = function
  | Mot m -> m
  | Italique ml -> "<em>" ^ liste_mots_string ml ^ "</em>"
  | Gras ml -> "<strong>" ^ liste_mots_string ml ^ "</strong>"
  | Lien (ml, m) -> "<a href=\"" ^ m ^ "\">" ^ liste_mots_string ml ^ "</a>"
  | Couleur (m, ml) -> "<span style=\"color :#" ^ m ^ "\">" ^ liste_mots_string ml ^ "</span>"
and texte_string = function
  | [] -> ""
  | hd :: tl -> element_de_texte_string hd ^ texte_string tl
and item_string t = "<li>" ^ texte_string t ^ "</li>\n"
and suite_items_string = function
  | [] -> ""
  | hd :: tl -> item_string hd ^ suite_items_string tl
and element_string = function
  | Titre1 t -> "<h1>" ^ texte_string t ^ "</h1>"
  | Titre2 t -> "<h2>" ^ texte_string t ^ "</h2>"
  | Paragraphe t -> "<p>" ^ texte_string t ^ "</p>"
  | SuiteItems s -> "<ul>\n" ^ suite_items_string s ^ "</ul>"
and corps_string = function
  | [] -> ""
  | [last] -> element_string last
  | hd :: tl -> element_string hd ^ "\n" ^ corps_string tl
and document_string v = corps_string v
