// 
// translit

#include <string.h>
#include "postgres.h"
#include "fmgr.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

const char translit_table[256][5] = {
	"\x00",	"\x01",	"\x02",	"\x03",	"\x04",	"\x05",	"\x06",	"\x07",	"\x08",	"\x09",	"\x0A",	"\x0B",	"\x0C",	"\x0D",	"\x0E",	"\x0F",
	"\x10",	"\x11",	"\x12",	"\x13",	"\x14",	"\x15",	"\x16",	"\x17",	"\x18",	"\x19",	"\x1A",	"\x1B",	"\x1C",	"\x1D",	"\x1E",	"\x1F",
	"\x20",	"\x21",	"\x22",	"\x23",	"\x24",	"\x25",	"\x26",	"\x27",	"\x28",	"\x29",	"\x2A",	"\x2B",	"\x2C",	"\x2D",	"\x2E",	"\x2F",
	"\x30",	"\x31",	"\x32",	"\x33",	"\x34",	"\x35",	"\x36",	"\x37",	"\x38",	"\x39",	"\x3A",	"\x3B",	"\x3C",	"\x3D",	"\x3E",	"\x3F",
	"\x40",	"\x41",	"\x42",	"\x43",	"\x44",	"\x45",	"\x46",	"\x47",	"\x48",	"\x49",	"\x4A",	"\x4B",	"\x4C",	"\x4D",	"\x4E",	"\x4F",
	"\x50",	"\x51",	"\x52",	"\x53",	"\x54",	"\x55",	"\x56",	"\x57",	"\x58",	"\x59",	"\x5A",	"\x5B",	"\x5C",	"\x5D",	"\x5E",	"\x5F",
	"\x60",	"\x61",	"\x62",	"\x63",	"\x64",	"\x65",	"\x66",	"\x67",	"\x68",	"\x69",	"\x6A",	"\x6B",	"\x6C",	"\x6D",	"\x6E",	"\x6F",
	"\x70",	"\x71",	"\x72",	"\x73",	"\x74",	"\x75",	"\x76",	"\x77",	"\x78",	"\x79",	"\x7A",	"\x7B",	"\x7C",	"\x7D",	"\x7E",	"\x7F",
	"\x80",	"\x81",	"\x82",	"\x83",	"\x84",	"\x85",	"\x86",	"\x87",	"\x88",	"\x89",	"\x8A",	"\x8B",	"\x8C",	"\x8D",	"\x8E",	"\x8F",
	"\x90",	"\x91",	"\x92",	"\x93",	"\x94",	"\x95",	"\x96",	"\x97",	"\x98",	"\x99",	"\x9A",	"\x9B",	"\x9C",	"\x9D",	"\x9E",	"\x9F",
	"\xA0",	"\xA1",	"\xA2",	"\xA3",	"\xA4",	"\xA5",	"\xA6",	"\xA7",	"\xA8",	"\xA9",	"\xAA",	"\xAB",	"\xAC",	"\xAD",	"\xAE",	"\xAF",
	"\xB0",	"\xB1",	"\xB2",	"\xB3",	"\xB4",	"\xB5",	"\xB6",	"\xB7",	"\xB8",	"\xB9",	"\xBA",	"\xBB",	"j",	"S",	"s",	"yi",
	"A",	"B",	"V",	"G",	"D",	"E",	"J",	"Z",	"I",	"Y",	"K",	"L",	"M",	"N",	"O",	"P",
	"R",	"S",	"T",	"U",	"F",	"H",	"C",	"Ch",	"Sh",	"Sch",	"",	"Y",	"",	"E",	"Yu",	"Ya",
	"a",	"b",	"v",	"g",	"d",	"e",	"j",	"z",	"i",	"y",	"k",	"l",	"m",	"n",	"o",	"p",
	"r",	"s",	"t",	"u",	"f",	"h",	"c",	"ch",	"sh",	"sch",	"",	"y",	"",	"e",	"yu",	"ya",
};

PG_FUNCTION_INFO_V1(translit);

Datum translit (PG_FUNCTION_ARGS) {

	text * arg = PG_GETARG_TEXT_P(0);

	size_t old_len = VARSIZE(arg) - VARHDRSZ;
	char * old_str = (char *)VARDATA(arg);
	char * new_str = (char *)palloc(old_len*4);

	char * pos = new_str;
	size_t i;
	for (i=0;i<old_len;i++) {
		unsigned char sym = old_str[i];
		const char *sub = translit_table[sym];
		size_t len = strlen(sub);
		memcpy(pos,sub,len);
		pos += len;
	};
	*pos = '\0';

	size_t new_len = pos-new_str;

	int32 new_size = VARHDRSZ + new_len;
	text *new_text = (text *) palloc(new_size);
	SET_VARSIZE(new_text, new_size);

	memcpy(VARDATA(new_text), new_str, new_len);

	PG_RETURN_TEXT_P(new_text);
};

/*

CREATE OR REPLACE FUNCTION translit (text) RETURNS text
	AS '/home/sol/prj/revo/src/sql/translit/translit','translit'
LANGUAGE C STRICT IMMUTABLE;

*/
