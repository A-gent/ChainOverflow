$connectionProfile = [Windows.Networking.Connectivity.NetworkInformation,Windows.Networking.Connectivity,ContentType=WindowsRuntime]::GetInternetConnectionProfile()
$tetheringManager = [Windows.Networking.NetworkOperators.NetworkOperatorTetheringManager,Windows.Networking.NetworkOperators,ContentType=WindowsRuntime]::CreateFromConnectionProfile($connectionProfile)

# Be sure to include Ben N.'s await for IAsyncOperation:
# https://superuser.com/questions/1341997/using-a-uwp-api-namespace-in-powershell

# Check whether Mobile Hotspot is enabled
$tetheringManager.TetheringOperationalState

# Start Mobile Hotspot
Await ($tetheringManager.StartTetheringAsync()) ([Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult])

# Stop Mobile Hotspot
Await ($tetheringManager.StopTetheringAsync()) ([Windows.Networking.NetworkOperators.NetworkOperatorTetheringOperationResult])