module freeflownation

import freeflowuniverse.spiderlib.uikit.flowbite
import net.http
import time
import vweb

pub struct Invitation {
pub:
	id        string    [primary]
	code      string [unique] // invitation code
	firstname string
	lastname  string
	email     string
	phone     string
	invitor_id string 
	invitee_id   string // id of citizen receiving the invitation
}
