module freeflownation

import rand
import json

[params]
pub struct InvitationConfig {
	name string
	email string
}

pub fn (mut app App) new_invitation(config InvitationConfig) !Invitation {
	app.logger.debug('Creating new invitation: ${json.encode(config)}')
	
	app.authorize_by_role(
		user_id: app.user_id,
		role: .citizen
	)!

	invitation_code := 'FFN-${rand.string(8)}'
	invitation := Invitation {
		firstname: config.name
		email: config.email
		code: invitation_code
	}
	
	app.create_invitation(invitation)
	app.logger.info('Created new invitation.')
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
