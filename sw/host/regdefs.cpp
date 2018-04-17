////////////////////////////////////////////////////////////////////////////////
//
// Filename:	../auto-generated/regdefs.cpp
//
// Project:	TinyZip, a demonstration project for the TinyFPGA B2 board
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	../../../autofpga/trunk/sw/autofpga ../../../autofpga/trunk/sw/autofpga -o ../auto-generated global.txt bkram.txt clock.txt dlyarbiter.txt pic.txt hbconsole.txt pwrcount.txt buserr.txt version.txt gpio.txt zipbones.txt flexpress.txt
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2018, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <ctype.h>
#include "regdefs.h"

const	REGNAME	raw_bregs[] = {
	{ R_BUSTIMER      ,	"BUSTIMER"	},
	{ R_BUSTIMER      ,	"BUSTIMER"	},
	{ R_WATCHDOG      ,	"WATCHDOG"	},
	{ R_WATCHDOG      ,	"WATCHDOG"	},
	{ R_CONSOLE_FIFO  ,	"UFIFO"   	},
	{ R_CONSOLE_UARTRX,	"RX"      	},
	{ R_CONSOLE_UARTTX,	"TX"      	},
	{ R_BUSERR        ,	"BUSERR"  	},
	{ R_BUSERR        ,	"BUSERR"  	},
	{ R_PIC           ,	"PIC"     	},
	{ R_PIC           ,	"PIC"     	},
	{ R_FLASHCFG      ,	"FLASHCFG"	},
	{ R_FLASHCFG      ,	"FLASHCFG"	},
	{ R_GPIO          ,	"GPIO"    	},
	{ R_GPIO          ,	"GPI"     	},
	{ R_GPIO          ,	"GPO"     	},
	{ R_GPIO          ,	"GPIO"    	},
	{ R_GPIO          ,	"GPI"     	},
	{ R_GPIO          ,	"GPO"     	},
	{ R_PWRCOUNT      ,	"PWRCOUNT"	},
	{ R_PWRCOUNT      ,	"PWRCOUNT"	},
	{ R_VERSION       ,	"VERSION" 	},
	{ R_VERSION       ,	"VERSION" 	},
	{ R_BKRAM         ,	"RAM"     	},
	{ R_FLASH         ,	"FLASH"   	}
};

// REGSDEFS.CPP.INSERT for any bus masters
// And then from the peripherals
// And finally any master REGS.CPP.INSERT tags
#define	RAW_NREGS	(sizeof(raw_bregs)/sizeof(bregs[0]))

const	REGNAME		*bregs = raw_bregs;
const	int	NREGS = RAW_NREGS;

unsigned	addrdecode(const char *v) {
	if (isalpha(v[0])) {
		for(int i=0; i<NREGS; i++)
			if (strcasecmp(v, bregs[i].m_name)==0)
				return bregs[i].m_addr;
#ifdef	R_ZIPCTRL
		if (strcasecmp(v, "CPU")==0)
			return R_ZIPCTRL;
#endif	// R_ZIPCTRL
#ifdef	R_ZIPDATA
		if (strcasecmp(v, "CPUD")==0)
			return R_ZIPDATA;
#endif	// R_ZIPDATA
		fprintf(stderr, "Unknown register: %s\n", v);
		exit(-2);
	} else
		return strtoul(v, NULL, 0);
}

const	char *addrname(const unsigned v) {
	for(int i=0; i<NREGS; i++)
		if (bregs[i].m_addr == v)
			return bregs[i].m_name;
	return NULL;
}

