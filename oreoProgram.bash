#!/bin/bash

# oreoProgram - Interactive Menu for User Feedback...

function show_menu() {
    clear
    echo "########################################################################"
    echo "########################################################################"
    echo "########################################################################"
    echo "######################  USER EXPERIENCE FEEDBACK  ######################"
    echo "######################           MENU            ######################"
    echo "########################################################################"
    echo "########################################################################"
    echo "########################################################################"
    echo
    echo "Please select from the options below:"
    echo
    echo "1. if you liked your experience"
    echo "2. if you disliked your experience"
    echo "3. if you would like to send a comment to our team"
    echo
    read -p "Enter your choice (1/2/3): " choice
}

function send_email() {
    local comment=$1
    local email="injootl5@gmail.com"
    local subject="User Feedback Comment"
    
    # Use mail command to send email (You need mail configured on your system)
    echo "$comment" | mail -s "$subject" "$email"
    if [ $? -eq 0 ]; then
        echo "Your comment has been sent successfully!"
    else
        echo "Failed to send your comment. Please ensure mail is configured properly."
    fi
}

function process_choice() {
    case $choice in
        1)
            echo "Thank you for your Amazing feedback :)"
            ;;
        2)
            echo "We are sorry for your experience."
            ;;
        3)
            read -p "Please enter your comment: " user_comment
            echo "Sending your comment..."
            send_email "$user_comment"
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
}

# Main program loop
while true; do
    show_menu
    process_choice
    read -p "Would you like to return to the menu? (y/n): " response
    if [[ $response != "y" ]]; then
        echo "Thank you for your feedback!"
        break
    fi
done
