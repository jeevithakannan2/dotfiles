/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const Gap default_gap        = {.isgap = 1, .realgap = 6, .gappx = 6};
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 34;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int vertpad            = 6;       /* vertical padding of bar */
static const int sidepad            = 6;       /* horizontal padding of bar */
static const unsigned int colorfultitle  = 1;  /* 0 means title use SchemeTitle and SchemeTitleFloat */
static const unsigned int colorfultag    = 1;  /* 0 means use SchemeSel for selected tag */
#define ICONSIZE 16   /* icon size */
#define ICONSPACING 5 /* space between icon and title */
static const char *fonts[]          = { "Noto Sans:pixelsize=18", "Symbols Nerd Font:pixelsize=18", "NotoColorEmoji:pixelsize=16:antialias=true:autohint=true"};

static const char black[]       = "#1E1D2D";
static const char gray2[]       = "#282737"; // unfocused window border
static const char gray3[]       = "#585767";
static const char gray4[]       = "#282737";
static const char blue[]        = "#96CDFB";  // focused window border
static const char green[]       = "#a6e3a1";
static const char red[]         = "#f38ba8";
static const char yellow[]      = "#FAE3B0";
static const char rosewater[]   = "#f5e0dc";
static const char lavender[]    = "#b4befe";
static const char col_borderbar[]  = "#1E1D2D"; // inner border
static const char white[] = "#f8f8f2";

static const char *colors[][3]      = {
	/*                       fg           bg           border   */
	[SchemeNorm]       = { gray3,   black,  gray2 },
    [SchemeSel]        = { gray4,   blue,   blue  },
    [SchemeTitle]      = { white,   black,  black }, // active window title
    [TabSel]           = { blue,    gray2,  black },
    [TabNorm]          = { gray3,   black,  black },
    [SchemeTag]        = { gray3,   black,  black },
    [SchemeTag1]       = { red,    black,  black },
    [SchemeTag2]       = { yellow,  black,  black },
    [SchemeTag3]       = { blue,     black,  black },
    [SchemeTag4]       = { white,   black,  black },
    [SchemeTag5]       = { lavender,    black,  black },
	[SchemeTag6]       = { green,    black,  black },
    [SchemeLayout]     = { rosewater,   black,  black },
};
/* tagging */
static const char *tags[] = { "", "", "", "", "", "󰓇" };

static const unsigned int ulinepad	= 5;	/* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;	/* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;	/* how far above the bottom of the bar the line should appear */
static const int ulineall 		= 0;	/* 1 to show underline on all tags, 0 for just the active ones */

static const int tagschemes[] = { 
	SchemeTag1, SchemeTag2, SchemeTag3, SchemeTag4, SchemeTag5, SchemeTag6
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ " ",      tile },    /* first entry is default */
	{ " ",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static const char *const autostart[] = {
  "dbus-update-activation-environment", "--systemd", "DISPLAY", NULL,
  "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1", NULL,
  "picom", "-b", NULL,
  "dunst", NULL,
  "nm-applet", "--indicator", NULL,
 // "sh", "-c", "xidlehook --detect-sleep --not-when-audio --not-when-fullscreen --timer 900 'slock' ''", NULL, // Create a service instead of autostarting with dwm
  "sh", "-c", "~/.config/bar.sh", NULL,
  "sh", "-c", "feh --bg-fill ~/.wallpaper.png", NULL,
  NULL
};

#include "movestack.c"

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          SHCMD("rofi -show drun") },
	{ MODKEY,                       XK_x,      spawn,          SHCMD("alacritty") },
	{ MODKEY,                       XK_b,      spawn,          SHCMD("xdg-open http:") },
	{ MODKEY,                       XK_e,      spawn,          SHCMD("thunar") },
	{ MODKEY,                       XK_F2,     togglebar,      {0} },
	{ MODKEY,                       XK_Left,   focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Right,  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Down,   incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_Up,     incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,   setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Right,  setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    cycleview,      {0} },
	{ MODKEY|ShiftMask,             XK_Tab,    cycleviewreverse,{0} },
	{ Mod1Mask,           			XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY|ShiftMask,             XK_n,      togglecolorfultag,   {0} },
	{ MODKEY,						XK_v,	   spawn,		   SHCMD("CM_LAUNCHER=rofi clipmenu") },
	{ 0,                            XF86XK_AudioMute,          spawn, SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle") },
    { 0,                            XF86XK_AudioLowerVolume,   spawn, SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5%") },
    { 0,                            XF86XK_AudioRaiseVolume,   spawn, SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5%") },
	{ 0,                            XF86XK_MonBrightnessDown,  spawn, SHCMD("brightnessctl set 5%-") },
    { 0,                            XF86XK_MonBrightnessUp,    spawn, SHCMD("brightnessctl set 5%+") },
	{ MODKEY|ShiftMask,             XK_q,      spawn,          SHCMD("$HOME/.config/rofi/powermenu.sh") },
    { MODKEY|ControlMask,           XK_q,      quit,           {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -5 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +5 } },
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = GAP_TOGGLE} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    /* placemouse options, choose which feels more natural:
    *    0 - tiled position is relative to mouse cursor
    *    1 - tiled postiion is relative to window center
    *    2 - mouse pointer warps to window center
    *
    * The moveorplace uses movemouse or placemouse depending on the floating state
    * of the selected client. Set up individual keybindings for the two if you want
    * to control these separately (i.e. to retain the feature to move a tiled window
    * into a floating position).
    */
    { ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 1} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

