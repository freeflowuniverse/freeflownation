module freeflownation

import freeflowuniverse.spiderlib.uikit.flowbite
import net.http
import time
import vweb

pub struct Invitation {
	id        int    [primary]
	code      string [unique] // invitation code
	firstname string
	lastname  string
	email     string
	phone     string
	invitee   string // id of citizen receiving the invitation
}
