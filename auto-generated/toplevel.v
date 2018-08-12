////////////////////////////////////////////////////////////////////////////////
//
// Filename:	../auto-generated/toplevel.v
//
// Project:	TinyZip, a demonstration project for the TinyFPGA B2 board
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	autofpga autofpga -o ../auto-generated global.txt bkram.txt buserr.txt pllclock.txt pic.txt pwrcount.txt version.txt hbconsole.txt gpio.txt dlyarbiter.txt zipbones.txt flexpress.txt
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
`default_nettype	none


//
// Here we declare our toplevel.v (toplevel) design module.
// All design logic must take place beneath this top level.
//
// The port declarations just copy data from the @TOP.PORTLIST
// key, or equivalently from the @MAIN.PORTLIST key if
// @TOP.PORTLIST is absent.  For those peripherals that don't need
// any top level logic, the @MAIN.PORTLIST should be sufficent,
// so the @TOP.PORTLIST key may be left undefined.
//
module	toplevel(i_clk,
		// GPIO ports
		i_gpio, o_gpio, o_led,
		// Top level Dual-SPI I/O ports
		o_dspi_cs_n, o_dspi_sck, io_dspi_dat,
		// UART/host to wishbone interface
		i_uart_rx, o_uart_tx);
	//
	// Declaring our input and output ports.  We listed these above,
	// now we are declaring them here.
	//
	// These declarations just copy data from the @TOP.IODECLS key,
	// or from the @MAIN.IODECL key if @TOP.IODECL is absent.  For
	// those peripherals that don't do anything at the top level,
	// the @MAIN.IODECL key should be sufficient, so the @TOP.IODECL
	// key may be left undefined.
	//
	input	wire		i_clk;
	localparam	NGPI = 12, NGPO=11;
	// GPIO ports
	input		[(12-1):0]	i_gpio;
	output	wire	[(11-1):1]	o_gpio;
	output	wire				o_led;
	// Dual SPI flash
	output	wire		o_dspi_cs_n;
	output	wire		o_dspi_sck;
	inout	wire	[1:0]	io_dspi_dat;
	input	wire		i_uart_rx;
	output	wire		o_uart_tx;


	//
	// Declaring component data, internal wires and registers
	//
	// These declarations just copy data from the @TOP.DEFNS key
	// within the component data files.
	//
	wire		s_clk, s_reset;
	wire	[1:0]	dspi_bmod;
	wire		w_dspi_sck;
	wire	[1:0]	dspi_dat;
	wire	[1:0]	i_dspi_dat;


	//
	// Time to call the main module within main.v.  Remember, the purpose
	// of the main.v module is to contain all of our portable logic.
	// Things that are Xilinx (or even Altera) specific, or for that
	// matter anything that requires something other than on-off logic,
	// such as the high impedence states required by many wires, is
	// kept in this (toplevel.v) module.  Everything else goes in
	// main.v.
	//
	// We automatically place s_clk, and s_reset here.  You may need
	// to define those above.  (You did, didn't you?)  Other
	// component descriptions come from the keys @TOP.MAIN (if it
	// exists), or @MAIN.PORTLIST if it does not.
	//

	main	thedesign(s_clk, s_reset,
		// GPIO wires
		i_gpio, { o_gpio, o_led },
		// Dual SPI flash
		o_dspi_cs_n, w_dspi_sck, dspi_dat, i_dspi_dat, dspi_bmod,
		// UART/host to wishbone interface
		i_uart_rx, o_uart_tx);


	//
	// Our final section to the toplevel is used to provide all of
	// that special logic that couldnt fit in main.  This logic is
	// given by the @TOP.INSERT tag in our data files.
	//


	assign	s_reset = 1'b0; // This design requires local, not global resets

`ifdef	VERILATOR
	assign	s_clk = i_clk;
`else
	wire	clk_25mhz, pll_locked;
	SB_PLL40_CORE #(
		.FEEDBACK_PATH("SIMPLE"),
		.DIVR(4'b0000),
		.DIVQ(3'b101),
		.DIVF(7'b011_0001),
		.FILTER_RANGE(3'b001))
		plli (
			// .PACKAGEPIN(i_clk),
			.REFERENCECLK(i_clk),
			.PLLOUTCORE(clk_25mhz),
			.LOCK(pll_locked),
			.BYPASS(1'b0), .RESETB(1'b1));

	SB_GB global_buffer(clk_25mhz, s_clk);
`endif


	//
	//
	// Wires for setting up the QSPI flash wishbone peripheral
	//
	//
	// QSPI)BMOD, Dual SPI bus mode, Bus modes are:
	//	0?	Normal serial mode, one bit in one bit out
	//	10	Dual SPI mode, going out
	//	11	Dual SPI mode coming from the device (read mode)
	SB_IO #(.PULLUP(1'b0), .PIN_TYPE(6'b101001))
		thedspi0 (.OUTPUT_ENABLE(dspi_bmod[1:0]!=2'b11),
				.PACKAGE_PIN(io_dspi_dat[0]),
				.D_OUT_0(dspi_dat[0]),
				.D_IN_0(i_dspi_dat[0]));

	SB_IO #(.PULLUP(1'b0), .PIN_TYPE(6'b101001))
		thedspi1 (.OUTPUT_ENABLE(dspi_bmod[1:0]==2'b10),
				.PACKAGE_PIN(io_dspi_dat[1]),
				.D_OUT_0(dspi_dat[1]),
				.D_IN_0(i_dspi_dat[1]));

	SB_IO #(.PIN_TYPE(6'b0100_01))
		thedspick (.OUTPUT_ENABLE(1'b1),
				.OUTPUT_CLK(s_clk),
				.CLOCK_ENABLE(1'b1),
				.D_OUT_0(!w_dspi_sck),
				.D_OUT_1(1'b1),
				.PACKAGE_PIN(o_dspi_sck));




endmodule // end of toplevel.v module definition
