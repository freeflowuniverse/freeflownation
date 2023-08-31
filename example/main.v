module main

import freeflowuniverse.spiderlib.auth
import freeflowuniverse.spiderlib.auth.email as email_auth
import freeflowuniverse.spiderlib.auth.session as session_auth
import freeflowuniverse.freeflownation
import vweb
import db.sqlite
import os
import time
import toml
import log

const db_dir = '${os.dir(@FILE)}/db'

const app_db = '${db_dir}/example.sqlite'

const auth_db = '${db_dir}/auth.sqlite'

const env_path = '${os.dir(@FILE)}/.env'

fn main() {
	do() or { panic(err) }
}

pub fn do() ! {
	mut logger := &log.Log{
		level: .debug
	}

	reset_database()!
	spawn run_auth_server(logger)
	mut app := configure_app(logger)!
	time.sleep(time.second) // wait a second for auth server to run

	// get email addresses that will be used to register the citizens in this example
	env := toml.parse_file(env_path) or { panic('Could not find .env, ${err}') }
	citizen_a_email := env.value('CITIZEN_A_EMAIL').string()
	citizen_b_email := env.value('CITIZEN_B_EMAIL').string()

	// register citizen with master code and login
	app.register(
		name: 'Citizen Alpha'
		email: citizen_a_email
		code: 'master_code'
	)!
	citizen_a_tokens := app.login(email: citizen_a_email)!

	// create invitation to register another citizen and login
	invitation := app.new_invitation()!
	app.register(
		name: 'Citizen Beta'
		email: citizen_b_email
		code: invitation.code
	)!

	citizen_b_tokens := app.login(email: citizen_b_email)!
}

fn reset_database() ! {
	if os.exists('${db_dir}/auth.sqlite') {
		os.rm('${db_dir}/auth.sqlite')!
	}
	if os.exists('${db_dir}/example.sqlite') {
		os.rm('${db_dir}/example.sqlite')!
	}
	if os.exists(db_dir) {
		os.rmdir(db_dir)!
	}
	os.mkdir(db_dir)!
}

fn run_auth_server(logger &log.Logger) {
	config := auth.ServerConfig{
		db_path: auth_db
		logger: unsafe { logger }
	}
	auth_server := auth.new_server(config) or { panic(err) }
	vweb.run(&auth_server, 8000)
}

fn configure_app(logger &log.Logger) !&freeflownation.App {
	mut app := freeflownation.new(
		env_path: os.dir(@FILE) + '/.env'
		logger: unsafe { logger }
		auth_server: 'http://localhost:8000'
		db: sqlite.connect(app_db) or { panic(err) }
	)
	return &app
}
