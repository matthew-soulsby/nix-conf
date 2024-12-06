{...}:

{
  programs.wlogout = {
    enable = true;
    style = ''
      * {
	      background-image: none;
	      box-shadow: none;
              font-family: "JetBrainsMono Nerd Font";
              font-size: 1.5rem;
      }
      
      window {
	      background-color: rgba(30, 30, 46, 0.90);
      }
      
      button {
              border-radius: 10;
              margin: 5;
	      border-color: #181825;
	      border-style: solid;
	      border-width: 1px;
	      text-decoration-color: #cdd6f4;
	      color: #cdd6f4;
	      background-color: #181825;
	      background-repeat: no-repeat;
	      background-position: center;
	      background-size: 25%;
      }
      
      button:focus, button:active, button:hover {
	      /* 20% Overlay 2, 80% mantle */
	      background-color: rgb(48, 50, 66);
	      outline-style: none;
	      border-color: #f2cdcd;
      }

      #lock {
          background-image: url("${../../assets/wlogout/mocha/flamingo/lock.svg}");
      }
      
      #logout {
          background-image: url("${../../assets/wlogout/mocha/flamingo/logout.svg}");
      }
      
      #suspend {
          background-image: url("${../../assets/wlogout/mocha/flamingo/suspend.svg}");
      }
      
      #hibernate {
          background-image: url("${../../assets/wlogout/mocha/flamingo/hibernate.svg}");
      }
      
      #shutdown {
          background-image: url("${../../assets/wlogout/mocha/flamingo/shutdown.svg}");
      }
      
      #reboot {
          background-image: url("${../../assets/wlogout/mocha/flamingo/reboot.svg}");
      }
    '';
  };
}
