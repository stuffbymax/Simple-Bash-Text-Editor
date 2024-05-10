#!/bin/bash

# Color variables
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
txtrst='\e[0m'    # Text Reset

# Function to get terminal size
get_terminal_size() {
    terminal_width=$(tput cols)
    terminal_height=$(tput lines)
}



# Function to display menu
display_menu() {
    get_terminal_size
    clear
    echo -e "${txtgrn} SBTE V0.1.9${txtrst}"
    echo ""
    echo -e "${txtgrn}1. Create a new file${txtrst}"
    echo -e "${txtgrn}2. Open an existing file${txtrst}"
    echo -e "${txtgrn}3. Edit existing file${txtrst}"
    echo -e "${txtgrn}4. Save file${txtrst}"
    echo -e "${txtgrn}5. Save As${txtrst}"
    echo -e "${txtgrn}6. Search for a word${txtrst}"
    echo -e "${txtgrn}7. Replace a word${txtrst}"
    echo -e "${txtgrn}8. Word Count${txtrst}"
    echo -e "${txtred}9. Delete a file${txtrst}"
    echo -e "${txtcyn}10. Time${txtrst}"
    echo -e "${txtcyn}11. System Info${txtrst}"
    echo -e "${txtgrn}12. About${txtrst}"
    echo -e "${txtblu}13. Visit our website${txtrst}"
    echo -e "${txtred}14. Exit${txtrst}"
    echo "--------------------------------------------------------------------------------"
}


# Function to create a new file
create_new_file() {
    echo "Enter the filename or full path of the new file:"
    read filenamepath
    vim "$filenamepath"
}

# Function to open an existing file
open_existing_file() {
    echo "Enter the filename or full path of the file to open:"
    read filenamepath
    vim "$filenamepath"
}

# Function to edit an existing file
edit_existing_file() {
    echo "Enter the filename or filepath of the file to edit:"
    read filenamepath
    vim "$filenamepath"
}

# Function to save the current file
save_file() {
    if [ -n "$filenamepath" ]; then
        echo "$text" > "$filenamepath"
        echo "File saved."
    else
        echo "No file is currently open."
    fi
}

# Function to save the current file with a new name
save_as() {
    echo "Enter the name of the file to save as:"
    read new_filename
    echo "$text" > "$new_filename"
    echo "File saved as $new_filename."
}

# Function to delete a file
delete_file() {
    echo "Enter the name of the file to delete:"
    read filename
    if [ -f "$filename" ]; then
        rm "$filename"
        echo "File deleted."
    else
        echo "File not found."
    fi
}

# Function to search for a word
search_word() {
    echo "Enter the word to search for:"
    read word
    if [ -n "$word" ]; then
        echo "$text" | grep -n "$word"
    else
        echo "Invalid input."
    fi
}

# Function to replace a word
replace_word() {
    echo "You are using Vim. Please use Vim commands to replace a word."
}

# Function to count words
word_count() {
echo "You are using Vim. Please use Vim commands to replace a word."
}

# Function to display the about information
display_about() {
    clear
    echo -e "${txtgrn}Simple Bash editor +VIM${txtrst}"
    echo -e""
    echo -e "${txtgrn}This is a simple text editor written in Bash.${txtrst}"
	echo -e "${txtred}The vim version is more helper tool then text editor${txtrst}"
    echo -e""
	echo -e "${txtred}some features are disable in +vim edition${txtrst}"
    echo -e "${txtgrn}It allows you to create, open, edit, and save text files.${txtrst}"
    echo -e "${txtgrn}You can also search for words, replace words, and count words.${txtrst}"
    echo ""
    echo -e "${txtgrn}PLEASE DO NOT USE THIS EDITOR AS YOUR MAIN PLEASE USE VIM OR NANO :)${txtrst}"
    echo -e "${txtgrn}OR USE THE VIM VERSION BUT I STILL DO NOT RECOMENT THIS PROJECT FOR ACTUALL USE untill full REALEASE${txtrst}"
    echo -e ""
}


# Function to handle time plugin
handle_time_plugin() {
    source ./plugins/time_plugin.sh
    display_current_time
}

# Function to handle system info plugin
handle_system_info_plugin() {
    source ./plugins/system_info_plugin.sh
    display_system_info
}


        5)
            save_as
            ;;
        6)
            search_word
            ;;
        7)
            replace_word
            ;;
        8)
            word_count
            ;;
        9)
            delete_file
            ;;
        10)
            handle_time_plugin
            ;;
        11)
            handle_system_info_plugin
            ;;
        12)
            display_about
            ;;
        13)
            visit_website  
            ;;
        14)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done
