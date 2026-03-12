{ config, pkgs, ... }:
let
  # Helpers for concise keybind definitions
  bind = keys: children: {
    bind = { _args = [ keys ]; } // children;
  };
  mode = m: { SwitchToMode = { _args = [ m ]; }; };
  focus = dir: { MoveFocus = { _args = [ dir ]; }; };
  focusOrTab = dir: { MoveFocusOrTab = { _args = [ dir ]; }; };
  resize = args: { Resize = { _args = [ args ]; }; };
  moveP = dir: { MovePane = { _args = [ dir ]; }; };
  newPane = dir: { NewPane = { _args = [ dir ]; }; };
  goToTab = n: { GoToTab = { _args = [ n ]; }; };
  search = dir: { Search = { _args = [ dir ]; }; };
  searchToggle = opt: { SearchToggleOption = { _args = [ opt ]; }; };
  noarg = name: { ${name} = {}; };
  plugin = name: props: {
    LaunchOrFocusPlugin = { _args = [ name ]; } // props;
  };
in
{
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "/run/current-system/sw/bin/nu";
      theme = "hachi";

      keybinds = {
        _props.clear-defaults = true;

        locked._children = [
          (bind "Ctrl g" (mode "normal"))
        ];

        pane._children = [
          (bind "left" (focus "left"))
          (bind "down" (focus "down"))
          (bind "up" (focus "up"))
          (bind "right" (focus "right"))
          (bind "c" ((mode "renamepane") // { PaneNameInput = { _args = [ 0 ]; }; }))
          (bind "d" ((newPane "down") // (mode "normal")))
          (bind "e" ((noarg "TogglePaneEmbedOrFloating") // (mode "normal")))
          (bind "f" ((noarg "ToggleFocusFullscreen") // (mode "normal")))
          (bind "h" (focus "left"))
          (bind "i" ((noarg "TogglePanePinned") // (mode "normal")))
          (bind "j" (focus "down"))
          (bind "k" (focus "up"))
          (bind "l" (focus "right"))
          (bind "n" ((noarg "NewPane") // (mode "normal")))
          (bind "p" (noarg "SwitchFocus"))
          (bind "Ctrl p" (mode "normal"))
          (bind "r" ((newPane "right") // (mode "normal")))
          (bind "s" ((newPane "stacked") // (mode "normal")))
          (bind "w" ((noarg "ToggleFloatingPanes") // (mode "normal")))
          (bind "z" ((noarg "TogglePaneFrames") // (mode "normal")))
        ];

        tab._children = [
          (bind "left" (noarg "GoToPreviousTab"))
          (bind "down" (noarg "GoToNextTab"))
          (bind "up" (noarg "GoToPreviousTab"))
          (bind "right" (noarg "GoToNextTab"))
          (bind "1" ((goToTab 1) // (mode "normal")))
          (bind "2" ((goToTab 2) // (mode "normal")))
          (bind "3" ((goToTab 3) // (mode "normal")))
          (bind "4" ((goToTab 4) // (mode "normal")))
          (bind "5" ((goToTab 5) // (mode "normal")))
          (bind "6" ((goToTab 6) // (mode "normal")))
          (bind "7" ((goToTab 7) // (mode "normal")))
          (bind "8" ((goToTab 8) // (mode "normal")))
          (bind "9" ((goToTab 9) // (mode "normal")))
          (bind "[" ((noarg "BreakPaneLeft") // (mode "normal")))
          (bind "]" ((noarg "BreakPaneRight") // (mode "normal")))
          (bind "b" ((noarg "BreakPane") // (mode "normal")))
          (bind "h" (noarg "GoToPreviousTab"))
          (bind "j" (noarg "GoToNextTab"))
          (bind "k" (noarg "GoToPreviousTab"))
          (bind "l" (noarg "GoToNextTab"))
          (bind "n" ((noarg "NewTab") // (mode "normal")))
          (bind "r" ((mode "renametab") // { TabNameInput = { _args = [ 0 ]; }; }))
          (bind "s" ((noarg "ToggleActiveSyncTab") // (mode "normal")))
          (bind "Ctrl t" (mode "normal"))
          (bind "x" ((noarg "CloseTab") // (mode "normal")))
          (bind "tab" (noarg "ToggleTab"))
        ];

        resize._children = [
          (bind "left" (resize "Increase left"))
          (bind "down" (resize "Increase down"))
          (bind "up" (resize "Increase up"))
          (bind "right" (resize "Increase right"))
          (bind "+" (resize "Increase"))
          (bind "-" (resize "Decrease"))
          (bind "=" (resize "Increase"))
          (bind "H" (resize "Decrease left"))
          (bind "J" (resize "Decrease down"))
          (bind "K" (resize "Decrease up"))
          (bind "L" (resize "Decrease right"))
          (bind "h" (resize "Increase left"))
          (bind "j" (resize "Increase down"))
          (bind "k" (resize "Increase up"))
          (bind "l" (resize "Increase right"))
          (bind "Ctrl n" (mode "normal"))
        ];

        move._children = [
          (bind "left" (moveP "left"))
          (bind "down" (moveP "down"))
          (bind "up" (moveP "up"))
          (bind "right" (moveP "right"))
          (bind "h" (moveP "left"))
          (bind "Ctrl h" (mode "normal"))
          (bind "j" (moveP "down"))
          (bind "k" (moveP "up"))
          (bind "l" (moveP "right"))
          (bind "n" (noarg "MovePane"))
          (bind "p" (noarg "MovePaneBackwards"))
          (bind "tab" (noarg "MovePane"))
        ];

        scroll._children = [
          (bind "e" ((noarg "EditScrollback") // (mode "normal")))
          (bind "s" ((mode "entersearch") // { SearchInput = { _args = [ 0 ]; }; }))
        ];

        search._children = [
          (bind "c" (searchToggle "CaseSensitivity"))
          (bind "n" (search "down"))
          (bind "o" (searchToggle "WholeWord"))
          (bind "p" (search "up"))
          (bind "w" (searchToggle "Wrap"))
        ];

        session._children = [
          (bind "a" ((plugin "zellij:about" {
            floating._args = [ true ];
            move_to_focused_tab._args = [ true ];
          }) // (mode "normal")))
          (bind "c" ((plugin "configuration" {
            floating._args = [ true ];
            move_to_focused_tab._args = [ true ];
          }) // (mode "normal")))
          (bind "Ctrl o" (mode "normal"))
          (bind "p" ((plugin "plugin-manager" {
            floating._args = [ true ];
            move_to_focused_tab._args = [ true ];
          }) // (mode "normal")))
          (bind "s" ((plugin "zellij:share" {
            floating._args = [ true ];
            move_to_focused_tab._args = [ true ];
          }) // (mode "normal")))
          (bind "w" ((plugin "session-manager" {
            floating._args = [ true ];
            move_to_focused_tab._args = [ true ];
          }) // (mode "normal")))
        ];

        "shared_except \"locked\""._children = [
          (bind "Alt left" (focusOrTab "left"))
          (bind "Alt down" (focus "down"))
          (bind "Alt up" (focus "up"))
          (bind "Alt right" (focusOrTab "right"))
          (bind "Alt +" (resize "Increase"))
          (bind "Alt -" (resize "Decrease"))
          (bind "Alt =" (resize "Increase"))
          (bind "Alt [" (noarg "PreviousSwapLayout"))
          (bind "Alt ]" (noarg "NextSwapLayout"))
          (bind "Alt f" (noarg "ToggleFloatingPanes"))
          (bind "Ctrl g" (mode "locked"))
          (bind "Alt h" (focusOrTab "left"))
          (bind "Alt i" { MoveTab = { _args = [ "left" ]; }; })
          (bind "Alt j" (focus "down"))
          (bind "Alt k" (focus "up"))
          (bind "Alt l" (focusOrTab "right"))
          (bind "Alt n" (noarg "NewPane"))
          (bind "Alt o" { MoveTab = { _args = [ "right" ]; }; })
          (bind "Alt p" (noarg "TogglePaneInGroup"))
          (bind "Alt Shift p" (noarg "ToggleGroupMarking"))
          (bind "Ctrl q" (noarg "Quit"))
        ];

        "shared_except \"locked\" \"move\""._children = [
          (bind "Ctrl h" (mode "move"))
        ];

        "shared_except \"locked\" \"session\""._children = [
          (bind "Ctrl o" (mode "session"))
        ];

        "shared_except \"locked\" \"scroll\" \"search\" \"tmux\""._children = [
          (bind "Ctrl b" (mode "tmux"))
        ];

        "shared_except \"locked\" \"scroll\" \"search\""._children = [
          (bind "Ctrl s" (mode "scroll"))
        ];

        "shared_except \"locked\" \"tab\""._children = [
          (bind "Ctrl t" (mode "tab"))
        ];

        "shared_except \"locked\" \"pane\""._children = [
          (bind "Ctrl p" (mode "pane"))
        ];

        "shared_except \"locked\" \"resize\""._children = [
          (bind "Ctrl n" (mode "resize"))
        ];

        "shared_except \"normal\" \"locked\" \"entersearch\""._children = [
          (bind "enter" (mode "normal"))
        ];

        "shared_except \"normal\" \"locked\" \"entersearch\" \"renametab\" \"renamepane\""._children = [
          (bind "esc" (mode "normal"))
        ];

        "shared_among \"pane\" \"tmux\""._children = [
          (bind "x" ((noarg "CloseFocus") // (mode "normal")))
        ];

        "shared_among \"scroll\" \"search\""._children = [
          (bind "PageDown" (noarg "PageScrollDown"))
          (bind "PageUp" (noarg "PageScrollUp"))
          (bind "left" (noarg "PageScrollUp"))
          (bind "down" (noarg "ScrollDown"))
          (bind "up" (noarg "ScrollUp"))
          (bind "right" (noarg "PageScrollDown"))
          (bind "Ctrl b" (noarg "PageScrollUp"))
          (bind "Ctrl c" ((noarg "ScrollToBottom") // (mode "normal")))
          (bind "d" (noarg "HalfPageScrollDown"))
          (bind "Ctrl f" (noarg "PageScrollDown"))
          (bind "h" (noarg "PageScrollUp"))
          (bind "j" (noarg "ScrollDown"))
          (bind "k" (noarg "ScrollUp"))
          (bind "l" (noarg "PageScrollDown"))
          (bind "Ctrl s" (mode "normal"))
          (bind "u" (noarg "HalfPageScrollUp"))
        ];

        entersearch._children = [
          (bind "Ctrl c" (mode "scroll"))
          (bind "esc" (mode "scroll"))
          (bind "enter" (mode "search"))
        ];

        renametab._children = [
          (bind "esc" ((noarg "UndoRenameTab") // (mode "tab")))
        ];

        "shared_among \"renametab\" \"renamepane\""._children = [
          (bind "Ctrl c" (mode "normal"))
        ];

        renamepane._children = [
          (bind "esc" ((noarg "UndoRenamePane") // (mode "pane")))
        ];

        "shared_among \"session\" \"tmux\""._children = [
          (bind "d" (noarg "Detach"))
        ];

        tmux._children = [
          (bind "left" ((focus "left") // (mode "normal")))
          (bind "down" ((focus "down") // (mode "normal")))
          (bind "up" ((focus "up") // (mode "normal")))
          (bind "right" ((focus "right") // (mode "normal")))
          (bind "space" (noarg "NextSwapLayout"))
          (bind "\"" ((newPane "down") // (mode "normal")))
          (bind "%" ((newPane "right") // (mode "normal")))
          (bind "," (mode "renametab"))
          (bind "[" (mode "scroll"))
          (bind "Ctrl b" ({ Write = { _args = [ 2 ]; }; } // (mode "normal")))
          (bind "c" ((noarg "NewTab") // (mode "normal")))
          (bind "h" ((focus "left") // (mode "normal")))
          (bind "j" ((focus "down") // (mode "normal")))
          (bind "k" ((focus "up") // (mode "normal")))
          (bind "l" ((focus "right") // (mode "normal")))
          (bind "n" ((noarg "GoToNextTab") // (mode "normal")))
          (bind "o" (noarg "FocusNextPane"))
          (bind "p" ((noarg "GoToPreviousTab") // (mode "normal")))
          (bind "z" ((noarg "ToggleFocusFullscreen") // (mode "normal")))
        ];
      };

      # Plugin aliases
      plugins = {
        about._props.location = "zellij:about";
        compact-bar._props.location = "zellij:compact-bar";
        configuration._props.location = "zellij:configuration";
        filepicker = {
          _props.location = "zellij:strider";
          cwd._args = [ "/" ];
        };
        plugin-manager._props.location = "zellij:plugin-manager";
        session-manager._props.location = "zellij:session-manager";
        status-bar._props.location = "zellij:status-bar";
        strider._props.location = "zellij:strider";
        tab-bar._props.location = "zellij:tab-bar";
        welcome-screen = {
          _props.location = "zellij:session-manager";
          welcome_screen._args = [ true ];
        };
      };

      web_client = {
        font._args = [ "monospace" ];
      };

      # Uncomment / modify these as needed:
      # simplified_ui = true;
      # default_mode = "locked";
      # default_shell = "fish";
      # default_cwd = "/tmp";
      # default_layout = "compact";
      # layout_dir = "/tmp";
      # theme_dir = "/tmp";
      # mouse_mode = false;
      # pane_frames = false;
      # mirror_session = true;
      # on_force_close = "quit";
      # scroll_buffer_size = 10000;
      # copy_command = "pbcopy";
      # copy_clipboard = "primary";
      # copy_on_select = true;
      # session_serialization = false;
      # serialize_pane_viewport = false;
      # scrollback_lines_to_serialize = 10000;
      # styled_underlines = false;
      # serialization_interval = 10000;
      # disable_session_metadata = false;
      # support_kitty_keyboard_protocol = false;
      # auto_layout = false;
      # stacked_resize = false;
      # show_startup_tips = false;
      # show_release_notes = false;
      # advanced_mouse_actions = false;
      # web_server = false;
      # web_sharing = "off";
    };

    themes.hachi = ''
      themes {
        hachi {
          frame_unselected {
            base 80 80 100
            background 24 24 36
            emphasis_0 120 110 180
            emphasis_1 150 130 220
            emphasis_2 180 160 255
            emphasis_3 200 190 255
          }
          frame_selected {
            base 150 130 220
            background 24 24 36
            emphasis_0 180 160 255
            emphasis_1 200 190 255
            emphasis_2 255 255 255
            emphasis_3 120 110 180
          }
          frame_highlight {
            base 180 160 255
            background 24 24 36
            emphasis_0 200 190 255
            emphasis_1 255 255 255
            emphasis_2 150 130 220
            emphasis_3 120 110 180
          }
          ribbon_unselected {
            base 180 180 200
            background 32 32 48
            emphasis_0 120 110 180
            emphasis_1 200 190 255
            emphasis_2 150 130 220
            emphasis_3 80 80 100
          }
          ribbon_selected {
            base 24 24 36
            background 150 130 220
            emphasis_0 255 255 255
            emphasis_1 200 190 255
            emphasis_2 180 160 255
            emphasis_3 120 110 180
          }
          text_unselected {
            base 180 180 200
            background 24 24 36
            emphasis_0 150 130 220
            emphasis_1 200 190 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          text_selected {
            base 255 255 255
            background 80 70 140
            emphasis_0 200 190 255
            emphasis_1 180 160 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          table_title {
            base 150 130 220
            background 24 24 36
            emphasis_0 180 160 255
            emphasis_1 200 190 255
            emphasis_2 255 255 255
            emphasis_3 120 110 180
          }
          table_cell_unselected {
            base 180 180 200
            background 24 24 36
            emphasis_0 150 130 220
            emphasis_1 200 190 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          table_cell_selected {
            base 255 255 255
            background 80 70 140
            emphasis_0 200 190 255
            emphasis_1 180 160 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          list_unselected {
            base 180 180 200
            background 24 24 36
            emphasis_0 150 130 220
            emphasis_1 200 190 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          list_selected {
            base 255 255 255
            background 80 70 140
            emphasis_0 200 190 255
            emphasis_1 180 160 255
            emphasis_2 130 200 150
            emphasis_3 220 100 100
          }
          exit_code_success {
            base 130 200 150
            background 24 24 36
            emphasis_0 150 220 170
            emphasis_1 100 180 120
            emphasis_2 80 160 100
            emphasis_3 60 140 80
          }
          exit_code_error {
            base 220 100 100
            background 24 24 36
            emphasis_0 240 120 120
            emphasis_1 200 80 80
            emphasis_2 180 60 60
            emphasis_3 160 40 40
          }
        }
      }
    '';
  };
}
