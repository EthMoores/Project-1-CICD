# Project-1-CICD

=================================
For the Bash script 
=================================
Explanation:
Interactive Menu: The show_menu function displays the feedback options and prompts the user to select a choice.
Choice Processing: The process_choice function handles the user's input:
1 for positive feedback.
2 for negative feedback.
3 lets the user type a c3omment, which is sent to the email via the mail command.
Mail Configuration: The program uses the mail command to send the comment, which requires an email system like sendmail or ssmtp to be configured on your machine.
Loop: The program loops and asks if the user wants to return to the menu. It only exits if they enter n.
Setup:
Ensure you have mail configured on your system (sendmail, ssmtp, or similar).
If you’re testing this without a mail configuration, comment out the send_email part and test the menu interactions first.
Let me know if you'd like to modify any part of this!!!

=================================
For the Jenkins Pipeline 
=================================

Stage 1: Check for Existing File.

The script checks if a file named oreoProgram already exists on the deployment machine.
If the file exists, it renames it by appending _Version_$number (e.g., oreoProgram_Version_1, oreoProgram_Version_2, etc.).
If the file does not exist, it pulls it from the Git repository using git checkout ${FILENAME}.
Stage 2: Make Executable

The script makes the oreoProgram file executable using chmod +x.
Stage 3: Archive Script

The script archives the oreoProgram file, saving it as a build artifact.
Post Section:

A success or failure message is posted based on the pipeline's execution.
If the pipeline succeeds, you'll see the message: Pipeline completed successfully!.
If it fails, you'll see the message: Pipeline failed..
Additional Notes:
The git checkout ${FILENAME} assumes that your Jenkins pipeline is connected to a Git repository with the oreoProgram file present.
The file versioning is based on the number of existing backup files. If any previous versions exist (e.g., oreoProgram_Version_1), the new file will be renamed with the next version number.
This pipeline should now meet your requirements for checking, renaming, and managing the oreoProgram file. Let me know if any further adjustments are needed!

