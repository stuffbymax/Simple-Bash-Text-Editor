# simple-text-editor
This project aims to provide a simple text editor with basic functionalities like creating, opening, editing, and saving text files.
-

if plugins doesnt work move the plugins and delete the folder
-

This program is a simple text editor implemented in Bash script. It provides basic functionalities like creating new files, opening existing files, editing files, saving files, searching for words, replacing words, counting words, and deleting files.
-
Here's a brief overview of its functionalities:
-
* Create a new file
* open an existing file
* Edit an existing file
* Save file
* Save As
* Search for a word
* Replace a word
* Word Count
* support plugins
* Delete a file
* Exit

#Vim Version
-
This program also has a Vim version It have same functionalities as the Bash script version but it opens the Vim text editor

Here's a brief overview of its functionalities:
-
* Create a new file
* pen an existing file
* Edit an existing file
* Save file
* Save As
* support plugins
* Delete a file
* Exit

## if the plugins doesnt work remove the plugins folder and put the files in same directory

also dont foreget to change the code 

`# Function to handle time plugin
handle_time_plugin() {
    source ./plugins/time_plugin.sh
    display_current_time
}`

`# Function to handle system info plugin
handle_system_info_plugin() {
    source ./plugins/system_info_plugin.sh
    display_system_info
}`

to

`# Function to handle time plugin
handle_time_plugin() {
    source ./time_plugin.sh
    display_current_time
}`

`# Function to handle system info plugin
handle_system_info_plugin() {
    source ./system_info_plugin.sh
    display_system_info
}
`
