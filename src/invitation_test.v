module freeflownation

import os
import vweb
import net.http
import db.sqlite
import log
import freeflowuniverse.spiderlib.auth

const auth_port = 8004
const db_path = '${os.dir(@FILE)}/db'
const test_db = '${db_path}/invitation_test.sqlite'
const env_path = '${os.dir(os.dir(@FILE))}/.env'

pub fn test_suite_begin() {
	if os.exists(test_db) {
		os.rm(test_db) or {panic(err)}
	}
	// run authentication server
	auth_server := auth.new_server() or {panic(err)}
	spawn vweb.run(&auth_server, auth_port)
}

pub fn test_suite_end() {
	if os.exists(test_db) {
		os.rm(test_db) or {panic(err)}
	}
}

pub fn test_new_invitation() {
	mut app := new(
		auth_server: 'http://localhost:8000'
		env_path: env_path
		db: sqlite.connect(freeflownation.test_db)!
	)

	app.register(
		name: 'Test Name'
		email: 'test@example.com'
		code: 'testcode'
	)!
}

fn run_auth_server() {	
	mut logger := log.Logger(&log.Log{
		level: .debug
	})
	auth_server := auth.new_server(
		logger: &logger
	) or {panic(err)}
	vweb.run(&auth_server, 8000)
}