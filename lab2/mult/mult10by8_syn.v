// megafunction wizard: %LPM_MULT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_mult

// ============================================================
// File Name: mult10by8.v
// Megafunction Name(s):
// 			lpm_mult
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.1.1 Build 166 11/26/2013 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions
//and other software and tools, and its AMPP partner logic
//functions, and any output files from any of the foregoing
//(including device programming or simulation files), and any
//associated documentation or information are expressly subject
//to the terms and conditions of the Altera Program License
//Subscription Agreement, Altera MegaCore Function License
//Agreement, or other applicable license agreement, including,
//without limitation, that your use is for the sole purpose of
//programming logic devices manufactured by Altera and sold by
//Altera or its authorized distributors.  Please refer to the
//applicable agreement for further details.


//lpm_mult DEDICATED_MULTIPLIER_CIRCUITRY="YES" DEVICE_FAMILY="Cyclone III" LPM_REPRESENTATION="SIGNED" LPM_WIDTHA=10 LPM_WIDTHB=8 LPM_WIDTHP=18 MAXIMIZE_SPEED=5 dataa datab result
//VERSION_BEGIN 13.1 cbx_cycloneii 2013:11:26:18:11:07:SJ cbx_lpm_add_sub 2013:11:26:18:11:07:SJ cbx_lpm_mult 2013:11:26:18:11:07:SJ cbx_mgl 2013:11:26:18:17:01:SJ cbx_padd 2013:11:26:18:11:07:SJ cbx_stratix 2013:11:26:18:11:07:SJ cbx_stratixii 2013:11:26:18:11:07:SJ cbx_util_mgl 2013:11:26:18:11:07:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = dsp_9bit 2
//synopsys translate_off
`timescale 1 ps / 1 ps 
//synopsys translate_on
module mult10by8_mult
       (
           dataa,
           datab,
           result )   /* synthesis synthesis_clearbox=1 */;
input [ 9: 0 ] dataa;
input [ 7: 0 ] datab;
output [ 17: 0 ] result;

wire [ 17: 0 ] wire_mac_mult1_dataout;
wire [ 17: 0 ] wire_mac_out2_dataout;

cycloneiii_mac_mult mac_mult1
                    (
                        .dataa( { dataa } ),
                        .datab( { datab } ),
                        .dataout( wire_mac_mult1_dataout ),
                        .signa( 1'b1 ),
                        .signb( 1'b1 )
                        `ifndef FORMAL_VERIFICATION
                        // synopsys translate_off
`endif
                        ,
                        .aclr( 1'b0 ),
                        .clk( 1'b1 ),
                        .ena( 1'b1 )
                        `ifndef FORMAL_VERIFICATION
                        // synopsys translate_on
`endif
                        // synopsys translate_off
                        ,
                        .devclrn( 1'b1 ),
                        .devpor( 1'b1 )
                        // synopsys translate_on
                    );
defparam
    mac_mult1.dataa_clock = "none",
    mac_mult1.dataa_width = 10,
    mac_mult1.datab_clock = "none",
    mac_mult1.datab_width = 8,
    mac_mult1.signa_clock = "none",
    mac_mult1.signb_clock = "none",
    mac_mult1.lpm_type = "cycloneiii_mac_mult";
cycloneiii_mac_out mac_out2
                   (
                       .dataa( wire_mac_mult1_dataout ),
                       .dataout( wire_mac_out2_dataout )
                       `ifndef FORMAL_VERIFICATION
                       // synopsys translate_off
`endif
                       ,
                       .aclr( 1'b0 ),
                       .clk( 1'b1 ),
                       .ena( 1'b1 )
                       `ifndef FORMAL_VERIFICATION
                       // synopsys translate_on
`endif
                       // synopsys translate_off
                       ,
                       .devclrn( 1'b1 ),
                       .devpor( 1'b1 )
                       // synopsys translate_on
                   );
defparam
    mac_out2.dataa_width = 18,
    mac_out2.output_clock = "none",
    mac_out2.lpm_type = "cycloneiii_mac_out";
assign
    result = wire_mac_out2_dataout[ 17: 0 ];
endmodule //mult10by8_mult
          //VALID FILE


          // synopsys translate_off
`timescale 1 ps / 1 ps
          // synopsys translate_on
          module mult10by8 (
              dataa,
              datab,
              result )  /* synthesis synthesis_clearbox = 1 */;

input	[ 9: 0 ] dataa;
input	[ 7: 0 ] datab;
output	[ 17: 0 ] result;

wire [ 17: 0 ] sub_wire0;
wire [ 17: 0 ] result = sub_wire0[ 17: 0 ];

mult10by8_mult	mult10by8_mult_component (
                   .dataa ( dataa ),
                   .datab ( datab ),
                   .result ( sub_wire0 ) );

endmodule

    // ============================================================
    // CNX file retrieval info
    // ============================================================
    // Retrieval info: PRIVATE: AutoSizeResult NUMERIC "1"
    // Retrieval info: PRIVATE: B_isConstant NUMERIC "0"
    // Retrieval info: PRIVATE: ConstantB NUMERIC "0"
    // Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
    // Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
    // Retrieval info: PRIVATE: Latency NUMERIC "0"
    // Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
    // Retrieval info: PRIVATE: SignedMult NUMERIC "1"
    // Retrieval info: PRIVATE: USE_MULT NUMERIC "1"
    // Retrieval info: PRIVATE: ValidConstant NUMERIC "0"
    // Retrieval info: PRIVATE: WidthA NUMERIC "10"
    // Retrieval info: PRIVATE: WidthB NUMERIC "8"
    // Retrieval info: PRIVATE: WidthP NUMERIC "18"
    // Retrieval info: PRIVATE: aclr NUMERIC "0"
    // Retrieval info: PRIVATE: clken NUMERIC "0"
    // Retrieval info: PRIVATE: new_diagram STRING "1"
    // Retrieval info: PRIVATE: optimize NUMERIC "0"
    // Retrieval info: LIBRARY: lpm lpm.lpm_components.all
    // Retrieval info: CONSTANT: LPM_HINT STRING "DEDICATED_MULTIPLIER_CIRCUITRY=YES,MAXIMIZE_SPEED=5"
    // Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "SIGNED"
    // Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MULT"
    // Retrieval info: CONSTANT: LPM_WIDTHA NUMERIC "10"
    // Retrieval info: CONSTANT: LPM_WIDTHB NUMERIC "8"
    // Retrieval info: CONSTANT: LPM_WIDTHP NUMERIC "18"
    // Retrieval info: USED_PORT: dataa 0 0 10 0 INPUT NODEFVAL "dataa[9..0]"
    // Retrieval info: USED_PORT: datab 0 0 8 0 INPUT NODEFVAL "datab[7..0]"
    // Retrieval info: USED_PORT: result 0 0 18 0 OUTPUT NODEFVAL "result[17..0]"
    // Retrieval info: CONNECT: @dataa 0 0 10 0 dataa 0 0 10 0
    // Retrieval info: CONNECT: @datab 0 0 8 0 datab 0 0 8 0
    // Retrieval info: CONNECT: result 0 0 18 0 @result 0 0 18 0
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8.v TRUE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8.inc FALSE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8.cmp FALSE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8.bsf TRUE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8_inst.v FALSE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8_bb.v TRUE
    // Retrieval info: GEN_FILE: TYPE_NORMAL mult10by8_syn.v TRUE
    // Retrieval info: LIB_FILE: lpm
