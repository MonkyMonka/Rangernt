#define init
	global.WeaponSprite = sprite_add_weapon("../sprites/weapons/sprSmallIron.png",0, 4)
#define weapon_name 
    return "Small Iron"; 
#define weapon_type 
    return 1; 
#define weapon_area 
    return -1;  
#define weapon_auto 
	return 0; 
#define weapon_cost 
    return 1; 
#define weapon_load 
    return 8; 
#define weapon_swap 
    return sndSwapPistol; 
#define weapon_sprt 
    return global.WeaponSprite; 
#define weapon_text 
    return "Not the gun that was on his hip"; 
#define weapon_melee 
    return 0;
#define weapon_fire 

	with(instance_create(x,y,CustomProjectile)){ 
		creator = other;
		team = creator.team;
		
		speed = random_range(8,10);
		friction = 0
		direction = creator.gunangle + random_range(-5,5);
		image_angle = direction;
		
		sprite_index = sprBullet1 
		mask_index = mskBullet1
		
		image_index = 0
		image_speed = 1
		image_xscale = 1
		image_yscale = 1
		
		damage = 3
		force = 3
		
		on_anim = generic_anim
		on_step = generic_step
		on_hit = generic_hit
		on_wall = generic_wall
		on_destroy = generic_destroy
		on_draw = generic_draw
	}

	sound_play_pitchvol(sndShotgun,1,1); 
	
	weapon_post(5,5,5)
	
#define generic_anim
	image_index = 1;
	Image_speed = 0;
	
#define generic_step
	instance_create(x,y,PlasmaTrail)
	
#define generic_hit
	projectile_hit(other, damage, force, direction)

	instance_create(x,y,Dust)

	instance_destroy();

#define generic_wall

	with other{
		instance_create(x,y,FloorExplo)
		instance_destroy();
	}
	
	sound_play(sndHitWall) 

	instance_destroy();

#define generic_destroy
	instance_create(x,y,BulletHit)

#define generic_draw

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	
	draw_set_blend_mode(bm_add)
	draw_sprite_ext(sprite_index, image_index, x, y, 1.9*image_xscale, 1.9*image_yscale, image_angle, image_blend, image_alpha * 0.2);
	draw_set_blend_mode(bm_normal)