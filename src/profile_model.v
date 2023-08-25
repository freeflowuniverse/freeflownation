module freeflownation

pub struct Profile {
	id         string
	firstname  string
	middlename string
	lastname   string
	name       string
	title      string
	bio        string
	education  string
	location   Location [fkey: 'id']
	// occupations []Occupation
	// skills []string
	// hobbies []string
}
