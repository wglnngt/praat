/* InfoEditor.cpp
 *
 * Copyright (C) 2004-2011 Paul Boersma
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * pb 2004/09/13
 * pb 2004/10/21 clear method also clears the info buffer, not just the visible text
 * pb 2007/05/24 wchar_t
 * pb 2007/06/09 more wchar_t
 * pb 2007/12/31 Gui
 * sdk 2008/03/24 Gui
 * pb 2010/07/29 removed GuiDialog_show
 * pb 2011/04/06 C++
 * pb 2011/04/16 C++
 */

#include "TextEditor.h"

/*
 * UGLY
 */
#undef our
#define our ((TextEditor_Table) my methods) ->

Thing_declare1cpp (InfoEditor);

struct structInfoEditor : public structTextEditor {
};
#define InfoEditor__methods(Klas) TextEditor__methods(Klas)
Thing_declare2cpp (InfoEditor, TextEditor);

static InfoEditor theInfoEditor;

static void destroy (I) {
	iam (InfoEditor);
	theInfoEditor = NULL;
	inherited (InfoEditor) destroy (me);
}

static void classInfoEditor_clear (InfoEditor me) {
	(void) me;
	Melder_clearInfo ();
}

class_methods (InfoEditor, TextEditor) {
	class_method (destroy)
	us -> scriptable = false;
	us -> fileBased = false;
	class_method_local (InfoEditor, clear)
	class_methods_end
}

extern "C" void gui_information (wchar_t *message);   // BUG
void gui_information (wchar_t *message) {
	if (! theInfoEditor) {
		theInfoEditor = Thing_new (InfoEditor);
		TextEditor_init (theInfoEditor, (GuiObject) Melder_topShell, L"");
		Thing_setName (theInfoEditor, L"Praat Info");
	}
	GuiText_setString (theInfoEditor -> textWidget, message);
	GuiObject_show (theInfoEditor -> dialog);
	GuiWindow_drain (theInfoEditor -> shell);
}

/* End of file InfoEditor.cpp */