open Button
(** represents the view in MVC pattern *)

val world_to_pixel : float * float -> int * int
(** [world_to_pixel (x, y)] is an integer coordinate pair in pixel space
    from the float coordinates in World *)

val pixel_to_world : int * int -> float * float
(** [pixel_to_world (x, y)] is a float coordinate pair in world space
    from the integer pixel coordinates in View *)

val init : unit
(** [init] instantiates a blank map *)

val draw_world : World.wt -> unit
(** [draw_world world display_controls] draws [world] onto the GUIs *)

val draw_input_popup : string -> string -> unit
(** [draw_input_popup prompt input] draws an input textfield with prompt
    text [prompt] and pending input text [input] *)

val draw_edit_mode : unit -> unit
(** [draw_edit_mode] draws the GUI overlay for edit mode *)

val draw_path : (float * float) list -> unit
(** [draw_path path] draws a line segment connecting coordinates in
    [path] specified in world space *)

val draw_button : button -> unit
(** [draw_button b] displays [button] as a rectangle *)

val draw_buttons : button list -> unit
(** [draw_buttons buttons ] displays all enabled buttons on the screen *)

val draw_location_instructions : unit -> unit
(** [draw_location_instructions () ] displays instructions on how to
    draw a location *)

val draw_road_instructions : unit -> unit
(** [draw_road_instructions () ] displays instructions on how to draw a
    road *)
