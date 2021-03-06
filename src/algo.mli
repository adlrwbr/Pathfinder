(** Bundle of various mathematical functions for data structures.

    This module is a collection of functions for data structure,
    containing the shortest path algorithm, breadth first traversal,
    slope, distance, and range checking. *)

exception UndefinedSlope
(** Raised when an undefined slope is calculated. *)

val relate : ('a -> 'a -> bool) -> 'a list -> 'a
(** [relate f list] is the element in [list] which survives a relation
    chain of [f]. Begins by comparing the first two values [f e1 e2]. If
    [f e1 e2] then repeat on [e1, e3, e4...], otherwise [e2, e3, e4...]
    until a single element remains. Requires: [list] has at least one
    element*)

val relate_option : ('a -> 'a -> bool) -> 'a list -> 'a option
(** [relate_option f list] is the same as [relate f list] except does
    not require [list] has >0 elements *)

val slope : float -> float -> float -> float -> float
(** [slope x1 y1 x2 y2] is the slope between two coordinate pairs (x1,
    y1) and (x2, y2). Raises: UndefinedSlope if [x1] = [x2] *)

val distance : float * float -> float * float -> float
(** [distance p1 p2] is the distance between coordinate pairs [p1] and
    [p2] *)

val in_range : float -> float -> float -> bool
(** [in_range p p1 p2] is whether or not [p] is between [p1] and [p2],
    inclusive. *)

val remove_all : 'a list -> 'a list -> 'a list
(** [remove_all list1 list2] is [list1] without the elements of [list2]*)

val breadth_first :
  (int -> int -> float) -> int -> int -> Graph.vgt -> int list
(** [breadth_first graph start_id end_id f] is the list of ids
    constituting the shortest path from [start_id] to [end_id] over the
    [graph], where weights edges between nodes are supplied by [f].
    Requires: [f] must be defined for all pairs of ids where an edge 
    exists between those ids. Not necessarily symmetric, i.e. f id1 id2
    is not always equal to f id2 id1, but must be defined for both. *)

val custom_path : (int -> int -> float) -> int -> int -> 
    Graph.vgt -> int list
(** [custom_path f start finish graph] is a list of the ids of the nodes
    along the minimum path from the id [start] to the id [finish] 
    within [graph] where edge weights are assigned by the function [f].
    [f id1 id2] needs to be defined for all edges within the graph,
    [f id1 id2] is not necessarily equal to [f id2 id1], but both
    must be defined.*)

val custom_distance : (int -> int -> float) -> int -> int 
    -> Graph.vgt -> float
    (** [custom_distance f id1 id2 graph] is the minimum distance between
    [id1] and [id2] where edge weights are assigned by [f id1 id2].
    [f] is not necessarily symmetric but must be defined both ways.*)


val shortest_path : int -> int -> Graph.vgt -> int list
(** [shortest_path start finish graph] is a list of the ids of the nodes
    along the shortest path from [start] to [finish], inclusive of endpoints.*)

val distance_between : int -> int -> Graph.vgt -> float
(** [distance_between graph id1 id2 f] is the shortest distance between
    [id1] and [id2].*)
