_: 
let 
  colors = {
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
    crust-transp = "rgba(17, 17, 27, 0.75)";
    red = "#FF6961";
    orange = "#FFB347";
    yellow = "#FDFD96";
    green = "#77DD77";
    cyan = "#AEC6CF";
    blue = "#779ECB";
    purple = "#CDB5E4";
    rosewater = "#f5e0dc";
  };

in ''

* {
  border: none;
  padding: 0;
  margin: 0;
  font-family: "FiraMono Nerd Font", monospace;
  font-size: 14px;
  font-weight: bold;
  min-height: 0;
}

window#waybar {
  background: transparent;
}

#custom-nix, #custom-powermenu{
	color: white;
  background: transparent;
}

#custom-nix {
  font-size: 30px;
}

#custom-powermenu {
  font-size: 20px;
}

#workspaces button {
	font-size: 20px;
  padding: 0px 6px;
  color: white;
}

#workspaces button.active {
	color: ${colors.purple};
}

#custom-nix, 
#workspaces, 
#clock, 
#custom-player,
#cava, 
#backlight, 
#network, 
#pulseaudio, 
#battery, 
#custom-powermenu {
  border: 0px solid transparent;
  border-radius: 4px;
  margin: 0px 8px;
  margin-top: 8px;
  padding: 0px 8px;
	background: ${colors.crust-transp};
}


.modules-left {
  color: white;
  padding-left: 8px;
}

.modules-center {
  color: white;
}

.modules-right {
  color: white;
  padding-right: 8px;
}

''
