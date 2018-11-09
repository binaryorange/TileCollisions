/// @desc Move the player

var bbox_side;


right = keyboard_check(vk_right);
left = keyboard_check(vk_left);
up = keyboard_check_pressed(ord("X"));
down = keyboard_check(vk_down);

hsp = (right - left) * 4;

// apply gravity
if !grounded {
	vsp += grav;
} else {
	vsp = 0;
}

// jump
if up && grounded {
	vsp -= jump;
}
#region -- Solid Collisions --
// Horizontal collision
if (hsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
if (tilemap_get_at_pixel(collision_tilemap, bbox_side+hsp, bbox_top) != 0 || tilemap_get_at_pixel(collision_tilemap, bbox_side+hsp, bbox_bottom) != 0) {

	if (hsp > 0) x = x - (x mod 64) + 63 - (bbox_right - x);
	else x = x - (x mod 64) - (bbox_left - x);
	hsp = 0;
	
}

// Vertical collision
if (vsp > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
if (tilemap_get_at_pixel(collision_tilemap, bbox_left, bbox_side+vsp) != 0 || tilemap_get_at_pixel(collision_tilemap, bbox_right, bbox_side+vsp) != 0) {

	if (vsp > 0) { 
		y = y - (y mod 64) + 63 - (bbox_bottom - y);
	} else { 
		y = y - (y mod 64) - (bbox_top - y);
	}	
	
	vsp = 0;
}
#endregion

#region -- One Way Collisions --

// check if the player is falling, or walking onto the platform

if (tilemap_get_at_pixel(oneway_tilemap, bbox_left, bbox_bottom+vsp) != 0 || tilemap_get_at_pixel(oneway_tilemap, bbox_right, bbox_bottom+vsp) != 0) {

	var tileY = (y div 64) * 64;
	if bbox_bottom >= tileY-64 and vsp >= 0 {	
		y = y + (y mod 64) - 63 + (bbox_bottom - y);
		vsp = 0;
	}
}
#endregion

#region -- Detect If Player Is Grounded --
if (tilemap_get_at_pixel(ground_tilemap, bbox_left, bbox_bottom+1) || tilemap_get_at_pixel(ground_tilemap, bbox_right, bbox_bottom+1)) and vsp == 0 {
	
	var tileY = (y div 64) * 64;
	if bbox_bottom+1 >= tileY-64 {	
		grounded = true;
	}
} else {
	grounded = false;
}
#endregion

// apply speeds
x += hsp;
y += vsp;