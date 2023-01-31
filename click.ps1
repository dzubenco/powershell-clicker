$InitialDelayMs = 5000
$IntervalMs = 60000
$x1 = 350
$x2 = 500
$y1 = 350
$y2 = 500
$RightClick = $false
$NoMove = $false

[Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

$DebugViewWindow_TypeDef = @'
[DllImport("user32.dll")]
public static extern IntPtr FindWindow(string ClassName, string Title);
[DllImport("user32.dll")]
public static extern IntPtr GetForegroundWindow();
[DllImport("user32.dll")]
public static extern bool SetCursorPos(int X, int Y);
[DllImport("user32.dll")]
public static extern bool GetCursorPos(out System.Drawing.Point pt);

[DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);

private const int MOUSEEVENTF_LEFTDOWN = 0x02;
private const int MOUSEEVENTF_LEFTUP = 0x04;
private const int MOUSEEVENTF_RIGHTDOWN = 0x08;
private const int MOUSEEVENTF_RIGHTUP = 0x10;

public static void LeftClick(){
    mouse_event(MOUSEEVENTF_LEFTDOWN | MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
}

public static void RightClick(){
    mouse_event(MOUSEEVENTF_RIGHTDOWN | MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
}
'@

Add-Type -MemberDefinition $DebugViewWindow_TypeDef -Namespace AutoClicker -Name Temp -ReferencedAssemblies System.Drawing

$pt = New-Object System.Drawing.Point
if ([AutoClicker.Temp]::GetCursorPos([ref]$pt)) {
	
	$MouseButton
	if ($RightClick) {
            $MouseButton = "RMB"
        } else {
            $MouseButton = "LMB"
		}
	Write-host "Waiting for ${InitialDelayMs}, then will click ${MouseButton} every ${IntervalMs} ms, until Ctrl^C is pressed or Start button"

    sleep -Milliseconds $InitialDelayMs

    while($true) {
        $start = [AutoClicker.Temp]::FindWindow("ImmersiveLauncher", "Start menu")
        $fg = [AutoClicker.Temp]::GetForegroundWindow()

        if ($start -eq $fg) {
            Write-Host "We've clicked the Start button. Turning off the script..."
            return
        }

        if (!$NoMove) {
		$curPosX = Get-Random -Maximum $x2 -Minimum $x1
		$curPosY = Get-Random -Maximum $y2 -Minimum $y1
	    $curTime = Get-Date -format "HH:mm:ss"
	    Write-Host "[${curTime}] ${MouseButton} clicked at point [${curPosX}, ${curPosY}]"
            [AutoClicker.Temp]::SetCursorPos($curPosX, $curPosY) | Out-Null

        }

        if ($RightClick) {
            [AutoClicker.Temp]::RightClick()
        } else {
            [AutoClicker.Temp]::LeftClick()
        }

        sleep -Milliseconds $IntervalMs
    }
}