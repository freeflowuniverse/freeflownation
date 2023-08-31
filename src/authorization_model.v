module freeflownation

enum Role {
	visitor // non-registered user
	registered // registered user without authenticated email
	citizen // registered user with authenticated email
	admin // admin user
}