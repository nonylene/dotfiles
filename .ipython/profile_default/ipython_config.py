# Configuration file for ipython.

## Configure matplotlib for interactive use with the default matplotlib backend.
#c.InteractiveShellApp.matplotlib = None

## The name of the IPython directory. This directory is used for logging
#  configuration (through profiles), history storage, etc. The default is usually
#  $HOME/.ipython. This option can also be specified through the environment
#  variable IPYTHONDIR.
#c.BaseIPythonApplication.ipython_dir = u''

## Make IPython automatically call any callable object even if you didn't type
#  explicit parentheses. For example, 'str 43' becomes 'str(43)' automatically.
#  The value can be '0' to disable the feature, '1' for 'smart' autocall, where
#  it is not applied if there are no more arguments on the line, and '2' for
#  'full' autocall, where all callable objects are automatically called (even if
#  no arguments are present).
c.InteractiveShell.autocall = 2

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'

## The number of saved history entries to be loaded into the history buffer at
#  startup.
c.InteractiveShell.history_load_length = 2000

##
#c.InteractiveShell.wildcards_case_sensitive = True

## Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
#  Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
#  direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

## The name or class of a Pygments style to use for syntax
#         highlighting:
#  manni, igor, lovelace, xcode, vim, autumn, abap, vs, rrt, native, perldoc, borland, arduino, tango, emacs, friendly, monokai, paraiso-dark, colorful, murphy, bw, pastie, rainbow_dash, algol_nu, paraiso-light, trac, default, algol, fruity
c.TerminalInteractiveShell.highlighting_style = 'monokai'
