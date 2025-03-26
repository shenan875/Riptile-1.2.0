@Echo off
Setlocal EnableDelayedExpansion

Set "path=%~dp0;%~dp0files;!cd!;!cd!\files;!path!;"

REM This General Layout, is generated by "FnC function By Kvc"

REM THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY
REM KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
REM WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
REM AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
REM HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
REM WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
REM DEALINGS IN THE SOFTWARE.

REM This program is distributed under the following license:

REM ================================================================================
REM GNU General Public License (GPL) - https://opensource.org/licenses/gpl-license
REM ================================================================================


REM ================= ABOUT THE PROGRAM =================
REM This program is Re-created (from '5:35 PM 2/17/2017') by Kvc at '02-12-2023 -  19:51'
REM This program this function prints a Button like interface on cmd 
REM For More Visit: www.batch-man.com
REM From TheBATeam ---to--- Now, Batch-Man

:: If you like my work, feel free to motivate me through your comments @ www.batch-man.com. 
REM ================================================================================


REM Setting version information...
REM Technically, this is version 3.0, but as i am adapting dated version control
REM this is now as per the last update of the function on the SACRED TIMELINE...
Set _ver=20231202

REM Checking for various parameters of the function...
If /i "%~1" == "--help" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "-help" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-?" (goto :help)
If /i "%~1" == "" (goto :help)

If /i "%~1" == "ver" (Echo.!_ver!&Goto :EOF)
If /i "%~1" == "" (goto :help)

If /i "%~2" == "" (goto :help)
If /i "%~3" == "" (goto :help)
If /i "%~4" == "" (goto :help)
If /i "%~5" == "" (goto :help)
If /i "%~6" == "" (goto :help)
If /i "%~7" == "" (goto :help)

REM Saving parameters to variables...
Set _1=%~1
Set _2=%~2
Set _3=%~3
Set _4=%~4
Set _5=%~5
Set _6=%~6
Set _7=%~7

REM Starting Main Program...
:Main

REM Setting-up variables for necessary calculations.
Set _Hover=
Set _Box=
Set _Text=
Set _Code=
Set _Reset_Loading_Text=
Set Button_height=3

:Loop_of_button_fn
REM Getting Button parameters...
Set _X=%~1
Set _Y=%~2
set color=%~3
Set _Invert_Color=!Color:~1,1!!Color:~0,1!
set "Button_text=%~4"

REM Loop Breaking Statements...
if not defined _X (goto :EOF)
if /i "!_X!" == "X" (Goto :End)

REM Checking the length of button according to Button_text
Call Getlen "..!button_text!.."
set button_width=!errorlevel!

REM Little math is important... :)
Set /A _X_Text=!_X! + 2
Set /A _Y_Text=!_Y! + 1
Set /A _X_End=!_X! + !button_width! - 1
Set /A _Y_End=!_Y! + !Button_height! - 1

REM Printing a Button like layout using Box Function!
Call Box !_X! !_Y! !Button_height! !button_width! - - !Color! 0 _Text

REM Saving Global variables...
Set "_Code=!_Code! !_Text! /g !_X_Text! !_Y_Text! /c 0x!color! /d "!Button_text!" "
Set "_Hover=!_Hover!!_Invert_Color! "
Set "_Box=!_Box!!_X! !_Y! !_X_End! !_Y_End! "

REM Showing temp 'Loading...' text in-place of buttons...
batbox /g !_X_Text! !_Y_Text! /d "Loading..."
Set "_Reset_Loading_Text=!_Reset_Loading_Text! /g !_X_Text! !_Y_Text! /d "          " "

REM Shifting the parameters for next button Code...
For /L %%A In (1,1,4) Do (Shift /1)
Goto :Loop_of_button_fn

:End
Quickedit 0 2>nul >nul
Batbox !_Reset_Loading_Text! !_Code! /c 0x07
Endlocal && set "%~2=%_Box%" && set "%~3=%_Hover%" && set "%~4=%_Code%"
Goto :EOF

:help
Echo.
Echo. This function helps in Adding a little GUI effect into your batch program.
echo. It Prints simple Button on the cmd console at specified X Y co-ordinate.
Echo. After printing, Returns the area of the button on CMD and the Inverted color
Echo. You can use this information in the main program with GetInput.exe Plugin of
Echo. Batch. And, it will make your life much more easier than before.
Echo. CREDITS: Button %_ver% by Kvc
Echo. 
echo. NOTE: IN THIS VERSION, AN ADDITIONAL PARAMETER IS ADDED @END OF CALL.
echo.       IT ALSO TAKES CARE OF THE QUICKEDIT MODE 'ISSUE' POST WIN 7 ERA.
echo.
echo. Syntax:
echo. call Button [Item 1] [Item 2] [Item 3] ... X _Var_Box _Var_Hover _Var_Code
echo. call Button [help ^| /^? ^| -h ^| -help ^| --help]
echo. call Button ver
echo.
echo. Where:-
Echo.
Echo. [Item] is short for this COMBINATION = [X] [Y] [color] "[Button Text]"
Echo.
echo. [X]	    X-ordinate of top-left corner of Button
echo. [Y]	    Y-co_ordinate of top-left corner of Button
echo. ver	    Version of Button function
Echo. [Item #]   The Buttons to display. Item Represents elements as told above.
echo.
Echo. X          Here, the Single 'X' (Must be FOURTH last element) indicates
Echo.            the Loop Sequence breaker for the Function. After 'X' You need
Echo.            to provide three Variables. Which will return the Corresponding 
Echo.            values for the GetInput.exe, and Batbox.exe 
echo.
Echo. _Var_Box   The THIRD last parameter, which is name of the variable to save
Echo.            the coordinates of All Buttons on console. (GetInput Supported)
Echo. _Var_Hover The SECOND last parameter, which is name of the variable to save
Echo.            mouse hover color for each button. (GetInput Supported)
Echo. _Var_Code  The LAST parameter, which is the name of the variable to save 
echo.            'batbox' supported code to print buttons on console Quickly
Echo.            without calling the button function again and again in loop.
Echo.
Echo. Use the above output variables with 'GetInput & Batbox' Plugins as follow:
Echo. EXAMPLE:
Echo.
Echo. Call Button 5 15 a0 "Button 1" 15 15 a0 "Button 2" X _Box _Hover _Code
echo. :Loop
echo. batbox %%_Code%%
Echo. GetInput /M %%_Box%% /H %%_Hover%%
echo. 
echo. If "%%Errorlevel%%" == "1" (Echo. Btn 1 Clicked.)
echo. If "%%Errorlevel%%" == "2" (Echo. Btn 1 Clicked.)
echo. timeout /t 3 >nul
echo. Goto :Loop
echo.
echo.
echo. This version %_Ver% of Button function contains much more GUI Capabilities.
echo. As it uses batbox.exe and calls it only once at the end of calculation...
Echo. For the most efficient output. This ver. uses GetInput By Aacini too. For the
Echo. Advanced Output on the console.
Echo.
echo. Visit www.Batch-man.com for more...
Echo.
Echo. PLUGINS REQUIRED FOR THIS PROJECT:
Echo. Box Function              by Kvc
Echo. Batbox                    by Darkbatcher
Echo. GetInput                  by Aacini
Echo. Getlen Function           by Kvc
Echo. Quickedit                 UNKNOWN
Echo.
Echo. www.batch-man.com
Echo. #batch-man
pause
Goto :End
