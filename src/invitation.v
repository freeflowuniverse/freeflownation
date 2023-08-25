module freeflownation

// // CRUD invitation operations

pub fn (mut app App) create_invitation(invitation Invitation) {
	sql app.db {
		insert invitation into Invitation
	} or { panic(err) }
}

// pub fn (app App) read_invitation(id string) ?Invitation {
// 		invitation := sql app.db {
// 			select from Invitation where id == id
// 		} or {panic(err)}
// 		return invitation[0] or {return none}
// 		// return none
// }

// fn (mut app App) update_invitation(invitation Invitation)! {
// 	id := app.get_value[string]('user_id') or {
// 		panic('not found')
// 	}
// 	sql app.db {
// 		update Invitation set
// 		firstname = invitation.firstname,
// 		lastname = invitation.lastname,
// 		email = invitation.email,
// 		phone = invitation.phone
// 		where id == id
// 	}!
// }

// pub fn (mut app App) delete_invitation(id string) {
// 	sql app.db {
// 		delete from Invitation where id == id
// 	} or {panic('err:${err}')}
// }
