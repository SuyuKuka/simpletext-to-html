exception MacroAlreadyDefine of string
exception NotExistMacro of string

(* Arbre *)
type document = corps

(* Macros *)
and liste_macros = macros list

and identifiant = nom

and macros = identifiant * texte

and nom = string

(* Corps *)
and corps = element list

and element =
  | Titre1 of texte
  | Titre2 of texte
  | Paragraphe of texte
  | SuiteItems of suite_items

and suite_items = item list

and item =
  | Item of texte
  | ItemImbrique of item_imbrique list

and item_imbrique =
  | ParagrapheImbrique of texte
  | SuiteItemsImbrique of suite_items

and texte = element_de_texte list

and element_de_texte =
  | Mot of mot
  | Italique of liste_mots
  | Gras of liste_mots
  | Lien of liste_mots * mot
  | Couleur of element_de_texte * liste_mots

and liste_mots = mot list

and mot = string

(* Affichage *)
let rec document_string v = corps_string v
and liste_macros_string = function
  | [] -> ""
  | [(i, t)] -> macros_string i t
  | (i, t) :: tl -> macros_string i t ^ "A" ^ liste_macros_string tl
and identifiant_string n = nom_string n
and macros_string i t = nom_string i ^ "B" ^ texte_string t
and nom_string s = s
and corps_string = function
  | [] -> ""
  | [last] -> element_string last
  | hd :: tl -> element_string hd ^ "\n" ^ corps_string tl
and element_string = function
  | Titre1 t -> "<h1>" ^ texte_string t ^ "</h1>"
  | Titre2 t -> "<h2>" ^ texte_string t ^ "</h2>"
  | Paragraphe t -> "<p>" ^ texte_string t ^ "</p>"
  | SuiteItems s -> "<ul>\n" ^ suite_items_string s ^ "</ul>"
and suite_items_string = function
  | [] -> ""
  | [last] -> item_string last ^ "\n"
  | hd :: tl -> item_string hd ^ "\n" ^ suite_items_string tl
and item_string = function
  | Item t -> "\t<li>" ^ texte_string t ^ "</li>"
  | ItemImbrique iil ->
    let rec aux = function
        | [] -> ""
        | [last] -> item_imbrique_string last ^ "\n"
        | hd :: tl -> item_imbrique_string hd ^ "\n" ^ aux tl
      in
    "<li>\n" ^ aux iil ^ "</li>"
and item_imbrique_string = function
  | ParagrapheImbrique t -> "<p>" ^ texte_string t ^ "</p>"
  | SuiteItemsImbrique si -> "<ul>\n" ^ suite_items_string si ^ "</ul>"
and texte_string = function
  | [] -> ""
  | [last] -> element_de_texte_string last
  (* Si il reste 2 élements de texte, *)
  (* il ne faut pas mettre d'espace lorsque hd1 n'est pas un 'Mot' *)
  | hd1 :: hd2 :: [] -> 
    (match hd1 with
    | Mot _ -> element_de_texte_string hd1 ^ " " ^ element_de_texte_string hd2
    | _ -> element_de_texte_string hd1 ^ element_de_texte_string hd2)
  (* On agit normalement dans les autres cas. *)
  | hd1 :: hd2 :: tl ->  
    element_de_texte_string hd1 ^ " " ^ texte_string (hd2 :: tl)
and element_de_texte_string = function
  | Mot m -> mot_string m
  | Italique ml -> "<em>" ^ liste_mots_string ml ^ "</em>"
  | Gras ml -> "<strong>" ^ liste_mots_string ml ^ "</strong>"
  | Lien (ml, m) -> "<a href=\"" ^ m ^ "\">" ^ liste_mots_string ml ^ "</a>"
  | Couleur (elt, ml) -> "<span style=\"color :#" ^ element_de_texte_string elt ^ "\">" ^ liste_mots_string ml ^ "</span>"
and liste_mots_string = function
  | [] -> ""
  | [last] -> last
  | hd :: tl -> hd ^ " " ^ liste_mots_string tl
and mot_string m = m
