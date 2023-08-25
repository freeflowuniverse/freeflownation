module freeflownation

import vweb

// CRUD citizen operations

// pub fn (mut app App) create_citizen(citizen Citizen) {
// 	sql app.db {
// 		insert citizen into Citizen
// 	} or {panic(err)}
// }

// pub fn (app App) read_citizen(id string) ?Citizen {
// 		citizen := sql app.db {
// 			select from Citizen where id == id
// 		} or {panic(err)}
// 		return citizen[0] or {return none}
// 		// return none
// }

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
