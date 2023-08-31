module freeflownation

// returns the authority role (citizen, admin etc.) of a given user
fn (app App) get_role(id string) Role {
	
	return .citizen
}


struct AuthorizeByRoleParams {
	user_id string // the access token of the user
	role Role
}

fn (app App) authorize_by_role(params AuthorizeByRoleParams) ! {
	role := app.get_role(params.user_id)
	if role != .citizen {
		return AuthError{reason: .unauthorized}
	}
}