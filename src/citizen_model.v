module freeflownation

import time

pub struct Citizen {
	id             string [primary]
	email          string
	email_verified bool
	phone          string
	// invitations []Invitation [fkey: 'invitor_id']
	created_at     time.Time [sql_type: 'DATETIME']
}

struct Occupation {
	id           string
	title        string
	organization string
	department   string
}

struct Location {
	id      string    [primary]
	city    string
	country string
}
