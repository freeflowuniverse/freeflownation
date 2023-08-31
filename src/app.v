module freeflownation

import freeflowuniverse.spiderlib.spider
// import freeflowuniverse.spiderlib.auth.email
import net.smtp
import toml
import log
import os
import db.sqlite
import freeflowuniverse.spiderlib.auth

pub struct App {
	env_path string
mut:
	user_id string
	db sqlite.DB
pub mut:
	logger &log.Logger = &log.Logger(&log.Log{
		level: .debug
	})
	auth_client auth.Client
}

[params]
pub struct AppConfig {
	auth_server string // url of the authentication server
	env_path    string [required] // path to .env file with env variables
mut:
	db sqlite.DB = sqlite.connect('freeflownation.db') or { panic(err) }
pub mut:
	logger &log.Logger = &log.Logger(&log.Log{
	level: .debug
})
}

pub fn new(config AppConfig) App {
	sql config.db {
		create table Citizen
		create table Invitation
	} or { panic(err) }

	return App{
		env_path: config.env_path
		db: config.db
		logger: config.logger
		auth_client: auth.new_client(
			auth_server: config.auth_server
		)
	}
}

pub struct SetUserParams {
	access_token string
	refresh_token string
}

pub fn (mut app App) set_user(params SetUserParams) ! {
	app.user_id = app.auth_client.get_token_subject(params.access_token) or {
		return AuthError{reason: .unauthenticated}
	}
}