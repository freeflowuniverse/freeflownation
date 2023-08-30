module freeflownation

import vweb
import freeflowuniverse.spiderlib.auth.email as email_auth
import net.http
import rand
import db.sqlite
import time
import toml

fn (mut app App) create_citizen(citizen_ Citizen) ! {
	if app.email_exists(citizen_.email) {
		return error('Citizen with email exists.')
	}
	// create unique id
	mut id := rand.uuid_v4()
	for app.citizen_id_exists(id) {
		id = rand.uuid_v4()
	}

	citizen := Citizen{
		...citizen_
		id: id
		created_at: time.now()
	}
	sql app.db {
		insert citizen into Citizen
	} or { panic(err) }
}

fn (mut app App) citizen_id_exists(id string) bool {
	citizens := sql app.db {
		select from Citizen where id == id
	} or { panic(err) }
	if citizens.len > 1 {
		panic('this should never happen')
	}
	return citizens.len == 1
}

fn (mut app App) email_exists(email string) bool {
	citizens := sql app.db {
		select from Citizen where email == email
	} or { panic(err) }
	if citizens.len > 1 {
		panic('this should never happen')
	}
	return citizens.len == 1
}

// returns the id of a citizen given the citizen's email
fn (mut app App) get_id_from_email(email string) string {
	citizens := sql app.db {
		select from Citizen where email == email
	} or { panic(err) }
	if citizens.len != 1 {
		panic('this should never happen')
	}
	return citizens[0].id
}

fn (mut app App) email_is_verified(email string) bool {
	citizens := sql app.db {
		select from Citizen where email == email
	} or { panic(err) }
	if citizens.len != 1 {
		panic('this should never happen')
	}
	return citizens[0].email_verified
}

fn (mut app App) set_email_verified(email string) {
	sql app.db {
		update Citizen set email_verified = true where email == email
	} or { panic(err) }
}

fn (mut app App) email_authentication(email string) ! {
	env := toml.parse_file(app.env_path) or { panic('Could not find .env, ${err}') }
	smtp_config := email_auth.SmtpConfig{
		server: env.value('SMTP_SERVER').string()
		from: 'verify@authenticator.io'
		port: env.value('SMTP_PORT').int()
		username: env.value('SMTP_USERNAME').string()
		password: env.value('SMTP_PASSWORD').string()
	}
	app.auth_client.email_authentication(
		email: email
		smtp: smtp_config
		link: ''
	)!
}