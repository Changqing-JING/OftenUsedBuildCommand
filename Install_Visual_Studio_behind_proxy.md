Installing Visual studio via Visual Studio Installer can use system proxy automatically, but installation of Visual Studio Installer.
To solve this problem, proxy setting need to be set in .NET config, because Visual Studio Installer follows the settings in .NET framework
Add following content to the system .net framework config

```xml
<system.net>
<defaultProxy enabled="true" useDefaultCredentials="true">
 <proxy bypassonlocal="True" proxyaddress="http://domain%5Cusername:password@youproxyaddress:portnumber"/>
</defaultProxy>
</system.net>
Replace the proxyaddress with a valid proxy of your office. Or you can also use a local proxy
```

Config path is `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config` and `C:\Windows\Microsoft.NET\Framework\v4.0.30319\Config\machine.config`
