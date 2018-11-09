/// @desc Initialize player in room


// set vsp and hsp to 0
vsp = 0;
hsp = 0;

// gravity
grav = 2.5;

// terminal velocity
terminal_velocity = 2;

jump = 30;

//grounded
grounded = false;
falling = true;
jumping = false;
can_jump = false;
colliding = false;

collide_solid = false;
collide_oneway = false;

// get the ID of the tilemap collision layer
collision_tilemap = layer_tilemap_get_id("Collisions");
oneway_tilemap = layer_tilemap_get_id("OneWayCollisions");
ground_tilemap = layer_tilemap_get_id("Ground");
