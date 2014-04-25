-- ------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 13.1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2013 Altera Corporation.  All rights reserved.
-- Your use of  Altera  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Altera Program License Subscription Agreement,
-- Altera  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Altera and sold by
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from lowpass_0002_rtl
-- VHDL created on Fri Apr 25 15:19:08 2014


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity lowpass_0002_rtl is
    port (
        xIn_v : in std_logic_vector(0 downto 0);
        xIn_c : in std_logic_vector(7 downto 0);
        xIn_0 : in std_logic_vector(11 downto 0);
        xOut_v : out std_logic_vector(0 downto 0);
        xOut_c : out std_logic_vector(7 downto 0);
        xOut_0 : out std_logic_vector(32 downto 0);
        clk : in std_logic;
        areset : in std_logic
    );
end lowpass_0002_rtl;

architecture normal of lowpass_0002_rtl is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";

    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_14_q : STD_LOGIC_VECTOR (11 downto 0);
    signal d_in0_m0_wi0_wo0_assign_sel_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_run_pre_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_count0_sc : SIGNED (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_ra1_count1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_a : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_b : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_o : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_ra1_add_0_0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal u0_m0_wo0_wi0_we1_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_we1_seq_eq : std_logic;
    signal u0_m0_wo0_wi0_wa0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_wa0_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_wa1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_wa1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_delayr0_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr0_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr0_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_reset0 : std_logic;
    signal u0_m0_wo0_wi0_delayr1_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr1_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_delayr1_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_delayr1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_ca1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_ca1_i : UNSIGNED (7 downto 0);
    signal u0_m0_wo0_ca1_eq : std_logic;
    signal u0_m0_wo0_mtree_mult1_1_a0 : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_b0 : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_a0 : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_b0 : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_s1 : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_accum_b : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_accum_i : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_accum_o : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_accum_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cm0_lutmem_reset0 : std_logic;
    signal u0_m0_wo0_cm0_lutmem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cm0_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_cm0_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_cm0_lutmem_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cm0_lutmem_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cm1_lutmem_reset0 : std_logic;
    signal u0_m0_wo0_cm1_lutmem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cm1_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_cm1_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_cm1_lutmem_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cm1_lutmem_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_oseq_gated_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_ra1_resize_in : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_ra1_resize_b : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- xIn(PORTIN,2)@10

    -- u0_m0_wo0_run(ENABLEGENERATOR,5)@10
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enable_q;
    u0_m0_wo0_run: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(8 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(251, 9);
            u0_m0_wo0_run_enable_q <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(8) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-252);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enable_q <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(8 downto 8));
            ELSE
                u0_m0_wo0_run_enable_q <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11";
                WHEN "100" => u0_m0_wo0_run_inc := "00";
                WHEN "101" => u0_m0_wo0_run_inc := "01";
                WHEN "110" => u0_m0_wo0_run_inc := "11";
                WHEN "111" => u0_m0_wo0_run_inc := "00";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_pre_ena_q <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_pre_ena_q and VCC_q;

    -- u0_m0_wo0_memread(DELAY,6)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_compute(DELAY,7)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_13(DELAY,38)@12
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_16(DELAY,39)@13
    d_u0_m0_wo0_compute_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_13_q, xout => d_u0_m0_wo0_compute_q_16_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_aseq(SEQUENCE,25)@16
    u0_m0_wo0_aseq: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "0000000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_16_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "0000000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 252;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(9 downto 9));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_17(DELAY,40)@16
    d_u0_m0_wo0_compute_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_16_q, xout => d_u0_m0_wo0_compute_q_17_q, clk => clk, aclr => areset );

    -- d_xIn_0_14(DELAY,35)@10
    d_xIn_0_14 : dspba_delay
    GENERIC MAP ( width => 12, depth => 4 )
    PORT MAP ( xin => xIn_0, xout => d_xIn_0_14_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_wa0(COUNTER,13)@14
    -- every=1, low=0, high=255, step=1, init=249
    u0_m0_wo0_wi0_wa0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_wa0_i <= TO_UNSIGNED(249, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_sel_q_14_q = "1") THEN
                u0_m0_wo0_wi0_wa0_i <= u0_m0_wo0_wi0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_wa0_i, 8)));

    -- d_in0_m0_wi0_wo0_assign_sel_q_14(DELAY,36)@10
    d_in0_m0_wi0_wo0_assign_sel_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4 )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_sel_q_14_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_memread_q_13(DELAY,37)@12
    d_u0_m0_wo0_memread_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => d_u0_m0_wo0_memread_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_ra1_count1(COUNTER,9)@13
    -- every=1, low=0, high=255, step=1, init=0
    u0_m0_wo0_wi0_ra1_count1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_count1_i <= TO_UNSIGNED(0, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_ra1_count1_i <= u0_m0_wo0_wi0_ra1_count1_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra1_count1_i, 9)));

    -- u0_m0_wo0_wi0_ra1_count0(COUNTER,8)@13
    -- every=253, low=0, high=255, step=4, init=253
    u0_m0_wo0_wi0_ra1_count0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_count0_i <= TO_UNSIGNED(253, 8);
            u0_m0_wo0_wi0_ra1_count0_sc <= TO_SIGNED(251, 9);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                IF (u0_m0_wo0_wi0_ra1_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra1_count0_sc <= u0_m0_wo0_wi0_ra1_count0_sc - (-252);
                ELSE
                    u0_m0_wo0_wi0_ra1_count0_sc <= u0_m0_wo0_wi0_ra1_count0_sc + (-1);
                END IF;
                IF (u0_m0_wo0_wi0_ra1_count0_sc(8) = '1') THEN
                    u0_m0_wo0_wi0_ra1_count0_i <= u0_m0_wo0_wi0_ra1_count0_i + 4;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_ra1_count0_i, 9)));

    -- u0_m0_wo0_wi0_ra1_add_0_0(ADD,10)@13
    u0_m0_wo0_wi0_ra1_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra1_count0_q);
    u0_m0_wo0_wi0_ra1_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_ra1_count1_q);
    u0_m0_wo0_wi0_ra1_add_0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_ra1_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_ra1_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_ra1_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_ra1_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_ra1_add_0_0_q <= u0_m0_wo0_wi0_ra1_add_0_0_o(9 downto 0);

    -- u0_m0_wo0_wi0_ra1_resize(BITSELECT,11)@14
    u0_m0_wo0_wi0_ra1_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_ra1_add_0_0_q(7 downto 0));
    u0_m0_wo0_wi0_ra1_resize_b <= u0_m0_wo0_wi0_ra1_resize_in(7 downto 0);

    -- u0_m0_wo0_wi0_delayr0(DUALMEM,15)@14
    u0_m0_wo0_wi0_delayr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_14_q);
    u0_m0_wo0_wi0_delayr0_aa <= u0_m0_wo0_wi0_wa0_q;
    u0_m0_wo0_wi0_delayr0_ab <= u0_m0_wo0_wi0_ra1_resize_b;
    u0_m0_wo0_wi0_delayr0_reset0 <= areset;
    u0_m0_wo0_wi0_delayr0_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => d_in0_m0_wi0_wo0_assign_sel_q_14_q(0),
        aclr0 => u0_m0_wo0_wi0_delayr0_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_delayr0_ab,
        q_b => u0_m0_wo0_wi0_delayr0_iq,
        address_a => u0_m0_wo0_wi0_delayr0_aa,
        data_a => u0_m0_wo0_wi0_delayr0_ia
    );
    u0_m0_wo0_wi0_delayr0_q <= u0_m0_wo0_wi0_delayr0_iq(11 downto 0);

    -- u0_m0_wo0_ca1(COUNTER,19)@12
    -- every=1, low=0, high=252, step=1, init=0
    u0_m0_wo0_ca1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca1_i <= TO_UNSIGNED(0, 8);
            u0_m0_wo0_ca1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_ca1_i = TO_UNSIGNED(251, 8)) THEN
                    u0_m0_wo0_ca1_eq <= '1';
                ELSE
                    u0_m0_wo0_ca1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_ca1_eq = '1') THEN
                    u0_m0_wo0_ca1_i <= u0_m0_wo0_ca1_i - 252;
                ELSE
                    u0_m0_wo0_ca1_i <= u0_m0_wo0_ca1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca1_i, 8)));

    -- u0_m0_wo0_cm0_lutmem(DUALMEM,33)@12
    u0_m0_wo0_cm0_lutmem_ia <= (others => '0');
    u0_m0_wo0_cm0_lutmem_aa <= (others => '0');
    u0_m0_wo0_cm0_lutmem_ab <= u0_m0_wo0_ca1_q;
    u0_m0_wo0_cm0_lutmem_reset0 <= areset;
    u0_m0_wo0_cm0_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 253,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 253,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "lowpass_0002_rtl_u0_m0_wo0_cm0_lutmem.hex",
        init_file_layout => "PORT_B",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => '0',
        aclr0 => u0_m0_wo0_cm0_lutmem_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_cm0_lutmem_ab,
        q_b => u0_m0_wo0_cm0_lutmem_iq,
        address_a => u0_m0_wo0_cm0_lutmem_aa,
        data_a => u0_m0_wo0_cm0_lutmem_ia
    );
    u0_m0_wo0_cm0_lutmem_q <= u0_m0_wo0_cm0_lutmem_iq(11 downto 0);

    -- u0_m0_wo0_mtree_mult1_1(MULT,22)@14
    u0_m0_wo0_mtree_mult1_1_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_lutmem_q);
    u0_m0_wo0_mtree_mult1_1_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr0_q);
    u0_m0_wo0_mtree_mult1_1_reset <= areset;
    u0_m0_wo0_mtree_mult1_1_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 12,
        lpm_widthb => 12,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 1
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_1_a0,
        datab => u0_m0_wo0_mtree_mult1_1_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_1_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_1_s1
    );
    u0_m0_wo0_mtree_mult1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_1_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_1_q <= u0_m0_wo0_mtree_mult1_1_s1;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_wa1(COUNTER,14)@14
    -- every=1, low=0, high=255, step=1, init=250
    u0_m0_wo0_wi0_wa1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_wa1_i <= TO_UNSIGNED(250, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_we1_seq_q = "1") THEN
                u0_m0_wo0_wi0_wa1_i <= u0_m0_wo0_wi0_wa1_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_wa1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_wa1_i, 8)));

    -- u0_m0_wo0_wi0_we1_seq(SEQUENCE,12)@13
    u0_m0_wo0_wi0_we1_seq: PROCESS (clk, areset)
        variable u0_m0_wo0_wi0_we1_seq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_we1_seq_c := "0000000000";
            u0_m0_wo0_wi0_we1_seq_q <= "0";
            u0_m0_wo0_wi0_we1_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                IF (u0_m0_wo0_wi0_we1_seq_c = "0000000000") THEN
                    u0_m0_wo0_wi0_we1_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_we1_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_we1_seq_eq = '1') THEN
                    u0_m0_wo0_wi0_we1_seq_c := u0_m0_wo0_wi0_we1_seq_c + 252;
                ELSE
                    u0_m0_wo0_wi0_we1_seq_c := u0_m0_wo0_wi0_we1_seq_c - 1;
                END IF;
                u0_m0_wo0_wi0_we1_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_we1_seq_c(9 downto 9));
            ELSE
                u0_m0_wo0_wi0_we1_seq_q <= "0";
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_delayr1(DUALMEM,17)@14
    u0_m0_wo0_wi0_delayr1_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr0_q);
    u0_m0_wo0_wi0_delayr1_aa <= u0_m0_wo0_wi0_wa1_q;
    u0_m0_wo0_wi0_delayr1_ab <= u0_m0_wo0_wi0_ra1_resize_b;
    u0_m0_wo0_wi0_delayr1_reset0 <= areset;
    u0_m0_wo0_wi0_delayr1_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "OLD_DATA",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => u0_m0_wo0_wi0_we1_seq_q(0),
        aclr0 => u0_m0_wo0_wi0_delayr1_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_wi0_delayr1_ab,
        q_b => u0_m0_wo0_wi0_delayr1_iq,
        address_a => u0_m0_wo0_wi0_delayr1_aa,
        data_a => u0_m0_wo0_wi0_delayr1_ia
    );
    u0_m0_wo0_wi0_delayr1_q <= u0_m0_wo0_wi0_delayr1_iq(11 downto 0);

    -- u0_m0_wo0_cm1_lutmem(DUALMEM,34)@12
    u0_m0_wo0_cm1_lutmem_ia <= (others => '0');
    u0_m0_wo0_cm1_lutmem_aa <= (others => '0');
    u0_m0_wo0_cm1_lutmem_ab <= u0_m0_wo0_ca1_q;
    u0_m0_wo0_cm1_lutmem_reset0 <= areset;
    u0_m0_wo0_cm1_lutmem_dmem : altsyncram
    GENERIC MAP (
        ram_block_type => "M9K",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 8,
        numwords_a => 253,
        width_b => 12,
        widthad_b => 8,
        numwords_b => 253,
        lpm_type => "altsyncram",
        width_byteena_a => 1,
        indata_reg_b => "CLOCK0",
        wrcontrol_wraddress_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        address_reg_b => "CLOCK0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "lowpass_0002_rtl_u0_m0_wo0_cm1_lutmem.hex",
        init_file_layout => "PORT_B",
        intended_device_family => "Cyclone III"
    )
    PORT MAP (
        clocken0 => '1',
        wren_a => '0',
        aclr0 => u0_m0_wo0_cm1_lutmem_reset0,
        clock0 => clk,
        address_b => u0_m0_wo0_cm1_lutmem_ab,
        q_b => u0_m0_wo0_cm1_lutmem_iq,
        address_a => u0_m0_wo0_cm1_lutmem_aa,
        data_a => u0_m0_wo0_cm1_lutmem_ia
    );
    u0_m0_wo0_cm1_lutmem_q <= u0_m0_wo0_cm1_lutmem_iq(11 downto 0);

    -- u0_m0_wo0_mtree_mult1_0(MULT,23)@14
    u0_m0_wo0_mtree_mult1_0_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm1_lutmem_q);
    u0_m0_wo0_mtree_mult1_0_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr1_q);
    u0_m0_wo0_mtree_mult1_0_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 12,
        lpm_widthb => 12,
        lpm_widthp => 24,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 1
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_0_a0,
        datab => u0_m0_wo0_mtree_mult1_0_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_0_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_0_s1
    );
    u0_m0_wo0_mtree_mult1_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_0_q <= u0_m0_wo0_mtree_mult1_0_s1;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_mtree_add0_0(ADD,24)@16
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 24 => u0_m0_wo0_mtree_mult1_0_q(23)) & u0_m0_wo0_mtree_mult1_0_q));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((24 downto 24 => u0_m0_wo0_mtree_mult1_1_q(23)) & u0_m0_wo0_mtree_mult1_1_q));
    u0_m0_wo0_mtree_add0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(24 downto 0);

    -- u0_m0_wo0_accum(ADD,26)@17
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 25 => u0_m0_wo0_mtree_add0_0_q(24)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_accum_b <= STD_LOGIC_VECTOR(u0_m0_wo0_accum_q);
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_17_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(32 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,27)@16
    u0_m0_wo0_oseq: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(9 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "0011111100";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_16_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "0000000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 252;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(9 downto 9));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,28)@17
    u0_m0_wo0_oseq_gated_a <= u0_m0_wo0_oseq_q;
    u0_m0_wo0_oseq_gated_b <= d_u0_m0_wo0_compute_q_17_q;
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_gated_a and u0_m0_wo0_oseq_gated_b;

    -- u0_m0_wo0_oseq_gated_reg(REG,29)@17
    u0_m0_wo0_oseq_gated_reg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- xOut(PORTOUT,32)@18
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;

END normal;
