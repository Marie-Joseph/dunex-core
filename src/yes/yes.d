/*
	Copyright (c) 2020, DUNEX Contributors
	Use, modification and distribution are subject to the
	Boost Software License, Version 1.0.  (See accompanying file
	COPYING or copy at http://www.boost.org/LICENSE_1_0.txt)

	yes: Repeatedly print specified string.

	Written by: chaomodus and Marie-Joseph
*/

module app;

import std.stdio;
import std.array;

import common.cmd;

enum APP_NAME = "yes";
enum APP_DESC = "Repeatedly print the specified string or 'y'.";
enum APP_VERSION = "1.0 (dunex-core)";
enum APP_AUTHORS = ["chaomodus", "Marie-Joseph"];
enum APP_LICENSE = import("COPYING");
enum APP_CAP = ["yes"];

int main(string[] args) {
    return runApplication(args, (Program app) {
            app.add(new Argument("string", "the string to print repeatedly").optional);
            app.add(new Flag("n", "no-newline", "omit newline character when printing").name("noNewline"));
        },
        (ProgramArgs args) {
            try {
                if (args.flag("noNewline")) {
                    if (args.arg("string").length == 0) {
                        while (true)
                            write("y");
                    } else {
                        while (true)
                            write(args.arg("string"));
                    }
                } else {
                    if (args.arg("string").length == 0) {
                        while (true)
                            writeln("y");
                    } else {
                        while (true)
                            writeln(args.arg("string"));
                    }
                }
            } catch(Exception ex) {
                stderr.writeln(APP_NAME, ": ", ex.msg);
                return 1;
            }
        }
    );
}
