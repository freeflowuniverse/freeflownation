module freeflownation

import time

pub struct Citizen {
	id             string
	email          string
	email_verified bool
	phone          string
	created_at     time.Time [sql_type: 'DATETIME']
}

struct Occupation {
	id           int
	title        string
	organization string
	department   string
}

struct Location {
	id      int    [primary]
	city    string
	country string
}
