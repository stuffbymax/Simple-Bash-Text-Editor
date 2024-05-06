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
