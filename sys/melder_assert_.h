#ifndef _hpp_melder_assert_
#define _hpp_melder_assert_

/* melder_assert_.h
 *
 * Copyright (C) 1992-2018 Paul Boersma
 *
 * This code is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This code is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this work. If not, see <http://www.gnu.org/licenses/>.
 */

void Melder_assert_ (const char *fileName, int lineNumber, const char *condition);
	/* Call Melder_fatal with a message based on the following template: */
	/*    "Assertion failed in file <fileName> on line <lineNumber>: <condition>" */
#ifdef NDEBUG
	#define Melder_assert(x)   ((void) 0)
#else
	#define Melder_assert(x)   ((x) ? (void) (0) : (Melder_assert_ (__FILE__, __LINE__, #x), abort ()))
#endif

/* End of file melder_assert_.h */
#endif
