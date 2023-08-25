module freeflownation

// // CRUD invitation operations

// returns false if code has been used or doesn't exist
fn (mut app App) code_is_valid(code string) bool {
	invitations := sql app.db {
		select from Invitation where code == code
	} or { panic(err) }
	if invitations.len == 0 {
		return false
	}
	if invitations[0].invitee != '' {
		return false
	}
	return true
}

[params]
struct UseInvitation {
	code    string // unique invitation code
	invitee string // id of citizen using invitation
}

fn (mut app App) use_invitation(params UseInvitation) {
	sql app.db {
		update Invitation set invitee = params.invitee where code == params.code
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
