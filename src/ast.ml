type mot = string
type texte = element_de_texte list

and element_de_texte =
  | Mot of mot
  | Italique of mot list
  | Gras of mot list
  | Lien of mot list * mot

type element =
  | Titre1 of texte
  | Titre2 of texte
  | Paragraphe of texte
  | Liste of texte list

type document = element list

let rec string_of_document doc =
  String.concat "\n\n" (List.map string_of_element doc)

and string_of_element = function
  | Titre1 t -> "# " ^ string_of_texte t
  | Titre2 t -> "## " ^ string_of_texte t
  | Paragraphe t -> string_of_texte t
  | Liste items ->
      if items = [] then
        ""  (* Liste vide, on ne l'affiche pas du tout *)
      else
        String.concat "\n" (List.map (fun i -> "\\item " ^ string_of_texte i) items)

and string_of_texte t =
  match t with
  | [] -> ""  (* Si le texte est vide, on retourne une chaîne vide *)
  | _ -> String.concat " " (List.map string_of_element_de_texte t)

and string_of_element_de_texte = function
  | Mot m -> m
  | Italique l -> "*" ^ String.concat " " l ^ "*"
  | Gras l -> "**" ^ String.concat " " l ^ "**"
  | Lien (txt, url) -> "[" ^ String.concat " " txt ^ "](" ^ url ^ ")"
