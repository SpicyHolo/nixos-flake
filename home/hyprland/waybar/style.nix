_: 
let 
  colors = {
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
    red = "#FF6961";
    orange = "#FFB347";
    yellow = "#FDFD96";
    green = "#77DD77";
    cyan = "#AEC6CF";
    blue = "#779ECB";
    purple = "#CDB5E4";
    rosewater = "#f5e0dc";
  };
  rainbow = {
    red = "#FF6961";
    orange = "#FFB347";
    yellow = "#FDFD96";
    green = "#77DD77";
    cyan = "#AEC6CF";
    blue = "#779ECB";
    purple = "#CDB5E4";
  };

in ''
* {
  border: none;
  border-radius: 0;
  font-family: Nerd Font Hack;
  font-size: 14px;
  font-weight: bold;
  min-height: 24px;
}



#window {
  margin-top: 0px;
  padding: 0px 16px;
  border-radius: 4px;
  transition: none;
  color:  ${colors.mantle};
}

window#waybar #window {
  color: ${colors.mantle};
}

window#waybar {
  background: transparent;
}

#clock {
  margin: 8px 0px 8px 8px;
  padding: 0px 8px;
	border-radius: 4px;
	transition: none;
	color: #f8f8f2;
	background: #282a36;
}

#custom-nix {
  margin: 4px 4px;
  padding-left: 4px;
	transition: none;
	color: #f8f8f2;
  font-size: 28px;
}

#workspaces {
  margin: 8px 0px 8px 8px;
	border-radius: 4px;
	background: #282a36;
	transition: none;
  box-shadow: none;
  text-shadow: none;
}

#workspaces button {
	transition: none;
	color: #f8f8f2;
	background: transparent;
	font-size: 16px;
}

#workspaces button.active {
	color: ${rainbow.red};
}

#custom-player {
  margin: 8px 0px 8px 8px;
  padding: 0px 16px;
	border-radius: 24px;
	transition: none;
	color: ${colors.crust};
  background-color: ${rainbow.purple};
}

#cava {
  margin: 8px 0px 8px 8px;
  padding: 0px 16px;
	transition: none;
	border-radius: 24px;
	color: ${colors.crust};
  background-color: ${rainbow.purple};
}

#backlight {
  margin: 8px 4px 8px 8px;
  padding-right: 8px;
  padding-left: 6px;
  border-radius: 4px;
  transition: none;
	color: ${colors.crust};
  background: ${rainbow.red};
}

#network {
  margin: 8px 4px 8px 8px;
  padding-right: 8px;
  padding-left: 4px;
	border-radius: 4px;
	transition: none;
	color: ${colors.crust};
	background: ${rainbow.green};
}

#pulseaudio {
  margin: 8px 4px 8px 8px;
  padding-right: 4px;
  padding-left: 2px;
	border-radius: 50%;
	transition: none;
	color: ${colors.crust};
	background: ${rainbow.blue};
}

#battery {
  margin: 8px 4px 8px 8px;
  padding-right: 8px;
  padding-left: 4px;
	border-radius: 28px;
	transition: none;
	color: ${colors.crust};
	background: ${rainbow.purple};
}


#custom-powermenu {
  margin: 4px 4px;
  padding-right: 4px;
	transition: none;
	color: #f8f8f2;
  font-size: 24px;

}

#custom-fcitx {
  margin: 4px 4px;
	transition: none;
	color: #f8f8f2;
  font-size: 24px;
}
''

