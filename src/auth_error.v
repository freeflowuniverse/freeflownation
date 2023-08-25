module freeflownation

pub struct AuthError {
	Error
	typ AuthErrorType
}

pub enum AuthErrorType {
	something
}
