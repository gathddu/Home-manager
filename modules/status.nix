{inputs, pkgs, config, ...}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "reloadi3" ''
      i3-msg reload
      i3-msg restart
    '')
    (pkgs.writeShellScriptBin "status_bar" ''
      while :
      do
        status_background
	      echo $(myDate) " | " $(systemStatus) " | " $(myBattery) $(myConnection) " | " $(facti)
	      sleep 5
      done
    '')
    (pkgs.writeShellScriptBin "myDate" ''
      date "+%a, %d, %H:%M"
    '')
    (pkgs.writeShellScriptBin "myBattery" ''
      bat = battery | cut -d' ' -f 2
      if [-n "$bat"]; then
        echo -e "\U1F50B" $(bat)% " | "
      fi
        echo ""
    '')
    (pkgs.writeShellScriptBin "systemStatus" ''
      echo $(temp)c, $(myDisk), $(myMem)
    '')
    (pkgs.writeShellScriptBin "myConnection" ''
      nmcli g | sed -n '2 p' | cut -d' ' -f 1
    '')
    (pkgs.writeShellScriptBin "myDisk" ''
      dysk --color no -c free --csv | sed -n "2 p" | sed 's/,//g'
    '')
    (pkgs.writeShellScriptBin "myMem" ''
      free -h | grep Mem | cut -d' ' -f 19
    '')
    (pkgs.writeShellScriptBin "facti" ''
        echo "BOBÓ CANCÚN"
    '')
  ];
}
