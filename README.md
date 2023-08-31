# Freeflow Nation

Backend for freeflownation application.
## Getting started

### Installation

To run this app you need the following vmodules:
- freeflowuniverse/crystallib
- freeflowuniverse/spiderlib

You can install necessary dependencies by running `v run install.vsh`
Note that, if you have the existing dependencies, they will not be installed. You should switch to the compatible branches of the dependent V modules to avoid bugs.

**Recommended VSCode Extensions**
- VOSCA.vscode-v-analyzer
- qwtel.sqlite-viewer

### Environment Variables

Check the .env file to see which environment variable you need to input. It is recommended to use a third party emailing SMTP client configuration to ensure that the emails the application sends are delivered.

## Example

The example demonstrates a user journey through the application. 
1. `citizen_a` registers with `remember_me: true`.
2. `citizen_a` invites `citizen_b`, which registers using `citizen_a`'s invitation. 
3. `citizen_a` views the invitation it's created, seeing that `citizen_b` registered using the invitation. 
4. The citizens view each other's profiles. 
5. application is closed and reopened
6. `citizen_a` is still able use the application, `citizen_b`'s token is invalid.

### Running the example

Before running the example make sure you've filled in all the necessary environment variables in the .env file. The example registers two separate citizens, and as such you must set two separate email addresses you have access to in the environment variables (see `example/.env` for details). 

To run the example, run the command `v run example`. Note that the for the example to run successfully you will have to click the verification link in the email you receive in both email account. This will register the users used in the example.  
## Docs

To generate docs, run `v run doc.vsh`. This opens two documents:
- **Manual** explains how to use the module. Recommended for developing projects using this module.
- **Reference** document code and internal functions. Recommended for developing this module.

## Authentication architecture

## Developing

### Source Folder

### Terminology

`caller_id`: id of the access token holder calling the function