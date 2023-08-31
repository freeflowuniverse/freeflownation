module freeflownation

struct AuthError {
	Error
	reason AuthErrorReason
}

pub enum AuthErrorReason {
	unauthenticated
	unauthorized
}

pub fn (err AuthError) msg() string {
	return match err.reason {
		.unauthenticated {
			'User has not been authenticated.'
		}
		.unauthorized {
			'User does not have the authority'
		}
	}
}