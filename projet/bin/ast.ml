open Hashtbl

(* Arbre *)
type document = liste_macros * corps

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
  | Macro of identifiant

and liste_mots = mot list

and mot = string

let macros_map : (identifiant, texte) t = create 16

(* Affichage *)
let rec document_string lm v = liste_macros_save lm; corps_string v
(* Macros *)
and liste_macros_save = function
  | [] -> ()
  | [(i, t)] -> macros_save i t
  | (i, t) :: tl -> macros_save i t; liste_macros_save tl
and macros_save i t = add macros_map (identifiant_string i) t
and identifiant_string n = nom_string n
and nom_string n = n
(* Corps *)
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
  | Macro i -> texte_string (find macros_map i)
and liste_mots_string = function
  | [] -> ""
  | [last] -> last
  | hd :: tl -> hd ^ " " ^ liste_mots_string tl
and mot_string m = m
