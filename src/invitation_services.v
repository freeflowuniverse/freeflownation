module freeflownation

import toml

// // CRUD invitation operations

// returns false if code has been used or doesn't exist
fn (mut app App) invitation_is_valid(code string) bool {
	// if code is master code invitation is valid
	env := toml.parse_file(app.env_path) or { panic('Could not find .env, ${err}') }
	master_code := env.value('MASTER_CODE').string()
	if code == master_code {
		return true
	}

	invitations := sql app.db {
		select from Invitation where code == code
	} or { panic(err) }
	if invitations.len == 0 {
		return false
	}
	if invitations[0].invitee_id != '' {
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
	// sql app.db {
	// 	update Invitation set invitee_id = params.invitee where code == params.code
	// } or { panic(err) }
}

fn (mut app App) create_invitation(invitation Invitation) {
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
