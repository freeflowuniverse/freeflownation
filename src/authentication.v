module freeflownation

import freeflowuniverse.spiderlib.auth.session
import vweb
import net.http
import rand
import time
import json

[params]
pub struct RegisterParams {
	name  string [required] // citizen's name
	email string [required] // citizen's email
	code  string [required] // invitation code
}

// register registers a citizen to freeflownation using an invitation code
pub fn (mut app App) register(params RegisterParams) ! {
	app.logger.debug('Registering citizen: ${json.encode(params)}')
	if app.email_exists(params.email) {
		return error('Citizen with email exists.')
	}
	if !app.code_is_valid(params.code) {
		return error('Invitation is already used.')
	}

	// create unique user id
	mut id := rand.uuid_v4()
	for app.citizen_id_exists(id) {
		id = rand.uuid_v4()
	}

	app.create_citizen(
		id: id
		// firstname: params.name
		email: params.email
	)!

	app.use_invitation(
		code: params.code
		invitee: id
	)
	app.logger.info('Registered citizen ${params.email} with id ${id}')
}

pub struct LoginParams {
	email       string // email used to log in
	remember_me bool   // whether user wants to remember on device
}

// login logs a user in by sending a verification link to their email
pub fn (mut app App) login(params LoginParams) !session.AuthTokens {
	app.logger.info('Logging in: ${json.encode(params)}')
	if !app.email_exists(params.email) {
		return error("Citizen with email doesn't exists.")
	}

	app.email_authentication(params.email) or {
		return error('Couldn\'t authenticate email: ${err}.')
	}

	citizen_id := app.get_id_from_email(params.email)
	app.logger.info('Citizen ${citizen_id} logged in')
	app.logger.debug('Generating authentication tokens for citizen ${citizen_id}')
	
	auth_tokens := app.auth_client.new_auth_tokens(
		user_id: citizen_id
		subject: citizen_id
		expiration: if params.remember_me { time.now().add_days(30) } else { time.now().add_days(1) }
	) or { return error('') }
	return auth_tokens
}

// // verify email sends
// pub fn (mut app App) verify_email(email string) ! {
// 	if !app.email_exists(email) {
// 		return error('Cannot verify email, no citizen with email found.')
// 	}
// 	if app.email_is_verified(email) {
// 		return error('Email already verified')
// 	}

// 	app.email_verification(email)
// 	app.set_email_verified(email)
// }
