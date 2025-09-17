<h2 align="center"> SDDM Theme - Nightsky </h2>

<p align=center>
 A simple theme for the <a href="https://github.com/sddm/sddm">SDDM Login Manager</a>
</p>

## How SDDM Themes Work

SDDM is the typical greeter (i.e., login manager) for KDE Plasma Linux Systems. It is closely integrated with the Plasma desktop and with Plasma 6, the integration has become even closer. 

SDDM's basic configuration is ugly, but the possibilities for customization are immense. A display manager paired with a modern distro should look good. SDDM is written using Qt libraries.  

Customizing using SDDM is very easy. In most cases, SDDM looks for themes in /usr/share/sddm/themes, so any themes we want to use should be placed in that directory. Distros like Fedora often come with themes, so the directory may not be empty. 

Switch to a different theme by editing the SDDM configuration file. It is located at /etc/sddm.conf. To change to the nightsky theme, for example, we would go to the [Theme] section and change it to look like:

```

[Theme]
Current=nightsky

```

### Previewing Themes

To get a preview of a new SDDM theme without needing to logout and login repeatedly, we can run the sddm-greeter utility to get a preview. We would pass the directory we want to test as the argument like so:

```

$ sddm-greeter --test-mode --theme /usr/share/nightsky

```

Once you're happy with the theme, you can apply it.


## Install 

### Dependencies

need adobe source code pro fonts

### From Source


### Arch Linux
sudo pacman -S adobe-source-code-pro-fonts


## Configure


## Credits

Some sites which were helpful:
- https://linuxconfig.org/how-to-customize-the-sddm-display-manager-on-linux


## License
