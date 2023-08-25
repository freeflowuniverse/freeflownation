module freeflownation

import db.sqlite

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
	mut app := new(
		db: sqlite.connect('test.db')!
	)
	profile := app.get_profile('profile_id', 'token')!
}
