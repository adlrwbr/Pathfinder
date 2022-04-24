let slope x1 y1 x2 y2 = (y2 -. y1) /. (x2 -. x1)

let distance p1 p2 =
    let x1, y1 = p1 in
    let x2, y2 = p2 in
    let dx = abs_float (x2 -. x1) in
    let dy = abs_float (y2 -. y1) in
    sqrt (dx *. dx +. dy *. dy)

let in_range p p1 p2 = (p >= p1 && p <= p2) || (p >= p2 && p <= p1)

let rec remove_all (list1 : 'a list) (list2 : 'a list) : 'a list = 
match list2 with 
| head :: tail -> remove_all (List.filter (fun x -> x <> head) list1) tail
| [] -> list1

let last (list : 'a list) : 'a = List.nth list (List.length list - 1);;
(** [last list] is the last element in the [list] 
    Requires: [list] is not empty. *)

let rec relate f list = match list with
| cur :: next :: more -> if f cur next then relate f (cur :: more) 
                         else relate f (next :: more)
| cur :: [] -> cur
| [] -> raise (Failure "No elements")

(** [gather_neighbors graph queue] is a list of pairs where:
the first component is the id of some node
the second component is the list of all its connections.  *)
let rec gather_neighbors graph queue except =
    match queue with    (**This remove_all prevents back_tracking but isn't necessary.*)
    | elem :: more -> 
        (remove_all (Graph.neighbors graph elem) except) :: gather_neighbors graph more except
    | [] -> []

let make_setlike list = List.sort_uniq compare list

let rec bfs graph queue memory output = 
    let links = gather_neighbors graph queue memory in
    let output = output @ [links] in 
    let queue = make_setlike (List.flatten links) in 
    if (remove_all queue memory) = [] then output else
    let memory = make_setlike (memory @ queue) in 
    (bfs graph queue memory output)

let breadth_first graph id = bfs graph [id] [id] [[[id]]]

let rec nodes_away_rec graph from towards counter =
    let path = breadth_first graph from in
    (match path with
    | single_source :: more -> 
    if single_source |> List.flatten |> List.mem towards then counter
    else nodes_away_rec graph from towards (counter + 1)
    | [] -> -1
    )
let nodes_away graph from towards = nodes_away_rec graph from towards 0
(** [nodes_away graph from towards] is the number of nodes between 
[from] and [towards] *)

let rec first_position elem heap counter =
    match heap with
    | depth_set :: more -> 
        if List.mem elem (List.flatten depth_set) then
            counter
        else
            first_position elem more (counter + 1)
    | [] -> raise (Failure "Item not found.")

let rec lop n list = match list with
| some :: more -> if n > 0 then lop (n-1) more else
    some :: lop 0 more
| [] -> []

let rec isolate_path start finish graph = 
    let heap = List.rev (breadth_first graph start) in 
    let subset = (lop (first_position finish heap 0) heap) in
    (subset)

let rec listworth elem list = 
    match list with 
    | some :: more -> if List.mem elem some then 0
    else 1 + listworth elem more
    | [] -> 0

let rec traceback start finish graph= 
    let reduced = isolate_path start finish graph in
    let origin = reduced |> List.hd in
    let pos = (listworth finish origin) in
    let next_pos = List.nth (List.nth reduced 1 |> List.flatten) pos in
    (if next_pos = start then [finish] @ [start]
    else [finish] @ traceback start next_pos graph
        )
        
let shortest_path start finish graph = traceback finish start graph
