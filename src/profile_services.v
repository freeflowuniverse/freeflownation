module freeflownation

import vweb

fn (app App) get_profile_by_id(id string) ?Profile {
	profiles := sql app.db {
		select from Profile where id == id
	} or { panic(err) }
	return profiles[0]
}

// pub fn (app App) read_citizens() []Citizen {
// 		citizens := sql app.db {
// 			select from Citizen
// 		} or {panic(err)}
// 		return citizens
// 		// return none
// }

// fn (mut app App) update_citizen(citizen Citizen)! {
// 	id := app.get_value[string]('user_id') or {
// 		panic('not found')
// 	}
// 	sql app.db {
// 		update Citizen set
// 		firstname = citizen.firstname,
// 		lastname = citizen.lastname,
// 		email = citizen.email,
// 		phone = citizen.phone
// 		where id == id
// 	}!
// }

// pub fn (mut app App) delete_citizen(id string) {
// 	sql app.db {
// 		delete from Citizen where id == id
// 	} or {panic('err:${err}')}
// }
