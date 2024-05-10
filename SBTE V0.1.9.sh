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
    if command -v tput >/dev/null 2>&1; then
        terminal_width=$(tput cols)
        terminal_height=$(tput lines)
    else
        # Fallback for terminals that do not support tput
        if [[ -n "$COLUMNS" && -n "$LINES" ]]; then
            terminal_width=$COLUMNS
            terminal_height=$LINES
        else
            # Default values in case terminal size cannot be determined
            terminal_width=80
            terminal_height=24
        fi
    fi
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
    read -rsn1  # Clear input buffer
    read filenamepath
    echo "Enter text (press Ctrl+D to save and exit):"
    text=$(cat)
    echo "$text" > "$filenamepath"
}

# Function to save the current file with its original name
save_file() {
    if [ -n "$filenamepath" ]; then
        echo "Enter the new name of the file:"
        read new_filename
        if [ -e "$new_filename" ]; then
            echo "File already exists. Do you want to overwrite it? (y/n)"
            read confirm
            if [ "$confirm" != "y" ]; then
                echo "Operation canceled."
                return
            fi
        fi
        cp "$filenamepath" "$new_filename"  # Copy the content of the original file to the new file
        echo "File content copied from $filenamepath to $new_filename."
        echo "$text" > "$new_filename"  # Write the content of the current buffer to the new file
        echo "File saved as $new_filename."
    else
        echo "No file is currently open."
    fi
}

# Function to open an existing file
open_existing_file() {
    echo "Enter the filename or full path of the file to open:"
    read filenamepath
    if [ -f "$filenamepath" ]; then
        lines_count=$(wc -l < "$filenamepath")
        page_size=$(tput lines)
        current_line=1
        while true; do
            clear
            echo "File: $filenamepath (Press 'q' to quit)"
            echo "--------------------------------------------------------------------------------"
            sed -n "$current_line,$((current_line+page_size-1))p" "$filenamepath" | nl -w3 -s'|' -v $current_line  # Add line numbers
            echo "--------------------------------------------------------------------------------"
            read -n 1 -s -r key
            case "$key" in
                q)
                    break
                    ;;
                k)
                    if [ "$current_line" -gt 1 ]; then
                        current_line=$((current_line-1))
                    fi
                    ;;
                j)
                    if [ "$((current_line+page_size-1))" -lt "$lines_count" ]; then
                        current_line=$((current_line+1))
                    fi
                    ;;
                *)
                    # Ignore other keys
                    ;;
            esac
        done
    else
        echo "File not found."
    fi
}

# Function to edit an existing file code from https://github.com/stuffbymax/STE-bed?tab=readme-ov-file
edit_existing_file() {
    echo "Enter the filename or filepath of the file to edit:"
    read -r filenamepath

    if [ -f "$filenamepath" ]; then
        bash bed.sh "$filenamepath"  # Call the bed.sh script with the filenamepath argument
    else
        echo "File not found."
    fi
}


# Function to save file as a new name
save_as() {
    echo "Enter the name of the file to create:"
    read new_filename
    if [ -e "$new_filename" ]; then
        echo "File already exists. Do you want to overwrite it? (y/n)"
        read confirm
        if [ "$confirm" != "y" ]; then
            echo "Operation canceled."
            return
        fi
    fi
    if [ -n "$filenamepath" ]; then
        echo "$text" > "$new_filename"  # Write the content of the current buffer to the new file
        filenamepath="$new_filename"  # Update the filenamepath variable
        echo "File created as $new_filename."
    else
        echo "No file is currently open."
    fi
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
    echo "Enter the word to replace:"
    read old_word
    echo "Enter the new word:"
    read new_word
    if [ -n "$old_word" ] && [ -n "$new_word" ]; then
        text=$(echo "$text" | sed "s/$old_word/$new_word/g")
        echo "Word replaced."
    else
        echo "Invalid input."
    fi
}

# Function to display the about information
display_about() {
    clear
    echo -e "${txtgrn}SBTE${txtrst}"
    echo -e""
    echo -e "${txtgrn}This is a simple text editor written in Bash.${txtrst}"
    echo -e""
    echo -e "${txtgrn}It allows you to create, open, edit, and save text files.${txtrst}"
    echo -e "${txtgrn}You can also search for words, replace words, and count words.${txtrst}"
    echo ""
    echo -e "${txtred}PLEASE DO NOT USE THIS EDITOR AS YOUR MAIN PLEASE USE VIM OR NANO :)${txtrst}"
    echo -e "${txtred}OR USE THE VIM VERSION BUT I STILL DO NOT RECOMENT THIS PROJECT FOR ACTUALL USE untill full REALEASE${txtrst}"
    echo -e ""
}

# Function to count words
word_count() {
    echo "Word count:"
    echo "$text" | wc -w
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

# Function to visit the website
visit_website() {
    echo "Opening STE website in your default web browser..."
    if command -v open &>/dev/null; then
        open "https://stuffbymax.github.io/ste-website/" 
    elif command -v xdg-open &>/dev/null; then
        xdg-open "https://stuffbymax.github.io/ste-website/" 
    else
        echo "Unable to open the website. because xdg-open or open doesnt work Please visit it manually in your web browser https://stuffbymax.github.io/ste-website/"
    fi
}


# Main loop
while true; do
    display_menu

    read -p "Enter your choice: " choice
    case $choice in
        1)
            create_new_file
            ;;
        2)
            open_existing_file
            ;;
        3)
            edit_existing_file
            ;;
        4)
            save_file
            ;;
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
