module freeflownation

import freeflowuniverse.spiderlib.auth
import db.sqlite
import log
import os
import time
import vweb

const env_path = '${os.dir(os.dir(@FILE))}/.env'
const test_db = 'profile_test.db'

pub fn test_suite_begin() {
	db := sqlite.connect(freeflownation.test_db)!
	sql db {
		drop table Citizen
		drop table Invitation
	} or { return }
}

pub fn test_suite_end() {
	db := sqlite.connect(freeflownation.test_db)!
	sql db {
		drop table Citizen
		drop table Invitation
	} or { return }
}

fn test_get_profile() {
	spawn run_auth_server()
	time.sleep(time.second)
	
	mut app := new(
		auth_server: 'http://localhost:8000'
		env_path: env_path
		db: sqlite.connect('test.db')!
	)

	profile := app.get_profile('profile_id', 'token')!
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