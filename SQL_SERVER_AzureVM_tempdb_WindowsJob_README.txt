Step 2.  Create a Windows Scheduler Task which will run that script each time the Virtual Machine Starts.

Click on Windows button and type ‘Scheduler’ – select and open task scheduler.
Click “Create Task”
On General Tab:
Set name to “SQL Startup”
Change user to run as a service account with permissions to create a folder and Start SQL services.
Select “Run whether the user is logged in or not.
On Triggers Tab:
Select “New”
Select “At Startup” from the dropbox menu.
Ensure “Enabled” is checked and click Okay.
On the Actions Tab:
Select “New”
Select Action as “Start a program”
For the program type(or browse to) powershell.exe
For Add Arguments type Powershell.exe -ExecutionPolicy Unrestricted -File “C:\Scripts\SQL-Startup.ps1”
Click Okay.
On the Conditions Tab:
No Changes
On the Settings Tab:
No Changes
Click Okay – You will be prompted for the credentials for the service account you selected to run the job under.
Step 3.  Set SQL to auto start(delayed)

Click Windows Start button and type “Services.msc”
Right click on the SQL Service and change Startup Type to “Automatic (Delayed Start)”
Click Okay.
Step 4.  Ensure Service Account has correct rights

Ensure your service account has sufficient permissions to start SQL and create a folder.
Ensure your service account has “Log on as a batch job” rights.