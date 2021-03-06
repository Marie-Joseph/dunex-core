/*
	Copyright (c) 2019, 2020, DUNEX Contributors
	Use, modification and distribution are subject to the
	Boost Software License, Version 1.0.  (See accompanying file
	COPYING or copy at http://www.boost.org/LICENSE_1_0.txt)

	Bugs:

	Todo:

*/

import std.conv;
import std.format;
import std.algorithm.searching;
import std.stdio;
import std.string;

import common.cmd;

enum APP_NAME = "uniq";
enum APP_DESC = "Manipulate repeated lines in input";
enum APP_VERSION = "1.0 (dunex-core)";
enum APP_AUTHORS = ["chaomodus"];
enum APP_LICENSE = import("COPYING");
enum APP_CAP = ["uniq"];

enum mode {
	   UNIQ,
	   REPEATS,
	   NONREPEATS
}

int main(string[] args) {
  try {
    return runApplication(args, (Program app) {
	app.add(new Argument("input", "The path to take input from (default is -, which means stdin)").defaultValue("-"));
	app.add(new Argument("output", "The path to return output to").defaultValue("-"));
	app.add(new Flag("c", "count", "Show the number of times each line repeats."));
	app.add(new Flag("d", "onlyrepeats", "Only show lines that have one or more repeats."));
	app.add(new Flag("u", "norepeats", "Only show lines that do not have repeats."));
	app.add(new Flag("i", "insensitive", "Compare lines case-insensitively."));
	app.add(new Option("f", "fieldskip", "Skip n blank-delimited fields.").defaultValue("0"));
	app.add(new Option("s", "charskip", "Skip n characters before comparing lines. Applied after field skip.").defaultValue("0"));
      },
      (ProgramArgs args) {
	string lastline;
	string lastcompline;
	string line;
	string compline;
	uint lastline_count = 1;
	uint fieldskip = to!uint(args.option("fieldskip"));
	uint charskip = to!uint(args.option("charskip"));
	bool start = true;
	mode progmode = mode.UNIQ;

	if (args.flag("onlyrepeats")) {
	  progmode = mode.REPEATS;
	} else if (args.flag("norepeats")) {
	  progmode = mode.NONREPEATS;
	}
	
	while (!stdin.eof) {
	  line = stdin.readln().strip(['\n']);
	  compline = line;

	  if (args.flag("insensitive"))
	    compline = compline.toLower();

	  if (fieldskip > 0) {
	    for (uint i = 0; i < fieldskip;  i++) {
	      auto res = findAmong(cast(char[])compline, [' ', '\t']);
		if (res) {
		  compline = to!string(res);
		} else {
		  break;
		}
	      }
	  }
	  
	  if (charskip > 0) {
	    if (charskip > compline.length) {
	      compline = "";
	    } else {
	      compline = compline[charskip-1..$];
	    }
	  }

	  if (lastcompline == compline) {
	    // repeat line
	    lastline_count += 1;
	  } else {
	    // new unique line
	    if (((progmode == mode.NONREPEATS) && lastline_count == 1) ||
		((progmode == mode.REPEATS) && lastline_count > 1) ||
		(progmode == mode.UNIQ)) {
	      if (!start) {
		writeln(lastline);
	      } else {
		start = false;
	      }
	    }
	    //reset
	    lastline_count = 1;
	  }
	  lastline = line;
	  lastcompline = compline;
	}
	return 0;
      });
  } catch(Exception ex) {
    stderr.writeln(APP_NAME, ": ", ex.msg);
    return 1;
  }
}
