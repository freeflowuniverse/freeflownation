module freeflownation

import vweb
import net.http
import db.sqlite

const test_db = 'auth_test.db'

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

pub fn test_new() {
	app := new()
}

pub fn test_register() {
	mut app := new(
		db: sqlite.connect(freeflownation.test_db)!
	)

	app.register(
		name: 'Test Name'
		email: 'test@example.com'
		code: 'testcode'
	)!
}
