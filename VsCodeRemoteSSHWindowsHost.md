# Setup VsCode Remote SSH on Windows Host

Install OPENSSH,
Open a PowerShell by Admin
```bat
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Set-Service -Name sshd -StartUpType 'Automatic'
Start-Service -Name sshd
```

Set user permission according to this link:
https://github.com/microsoft/vscode-remote-release/issues/2648#issuecomment-1293832539