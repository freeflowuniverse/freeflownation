module freeflownation

import rand
// // CRUD invitation operations

[params]
pub struct InvitationConfig {
	name string
	email string
}

pub fn (mut app App) new_invitation(token string, config InvitationConfig) !Invitation {
	caller_id := app.auth_client.get_token_subject(token) or {
		return AuthError{reason: .unauthenticated}
	}

	invitation_code := 'FFN-${rand.string(8)}'
	invitation := Invitation {
		firstname: config.name
		email: config.email
		code: invitation_code
	}
	// app.create_invitation(invitation)
	return invitation
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
