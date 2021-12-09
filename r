#! /usr/local/bin/vvp
:ivl_version "12.0 (devel)" "(s20150603-1148-gef01dd1e)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "/usr/local/lib/ivl/system.vpi";
:vpi_module "/usr/local/lib/ivl/vhdl_sys.vpi";
:vpi_module "/usr/local/lib/ivl/vhdl_textio.vpi";
:vpi_module "/usr/local/lib/ivl/v2005_math.vpi";
:vpi_module "/usr/local/lib/ivl/va_math.vpi";
:vpi_module "/usr/local/lib/ivl/v2009.vpi";
S_0x556788a914d0 .scope package, "$unit" "$unit" 2 1;
 .timescale 0 0;
S_0x556788a7fcf0 .scope module, "regfile" "regfile" 3 7;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "clk";
    .port_info 1 /INPUT 1 "rst";
    .port_info 2 /INPUT 5 "addr_rs";
    .port_info 3 /INPUT 5 "addr_rt";
    .port_info 4 /INPUT 1 "write_enable_ld";
    .port_info 5 /INPUT 1 "write_enable_ALU";
    .port_info 6 /INPUT 1 "write_enable_PC";
    .port_info 7 /INPUT 1 "link";
    .port_info 8 /INPUT 5 "addr_rd";
    .port_info 9 /INPUT 32 "write_data_ld";
    .port_info 10 /INPUT 32 "write_data_ALU";
    .port_info 11 /INPUT 32 "write_data_PC";
    .port_info 12 /OUTPUT 32 "read_data_1";
    .port_info 13 /OUTPUT 32 "read_data_2";
    .port_info 14 /INPUT 4 "byteenable_ld";
    .port_info 15 /INPUT 1 "rType";
    .port_info 16 /OUTPUT 32 "v0";
    .port_info 17 /INPUT 2 "state";
v0x556788add190_2 .array/port v0x556788add190, 2;
L_0x556788ade420 .functor BUFZ 32, v0x556788add190_2, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>, C4<00000000000000000000000000000000>;
o0x7f305b15f018 .functor BUFZ 5, C4<zzzzz>; HiZ drive
v0x556788aaef70_0 .net "addr_rd", 4 0, o0x7f305b15f018;  0 drivers
o0x7f305b15f048 .functor BUFZ 5, C4<zzzzz>; HiZ drive
v0x556788adc900_0 .net "addr_rs", 4 0, o0x7f305b15f048;  0 drivers
o0x7f305b15f078 .functor BUFZ 5, C4<zzzzz>; HiZ drive
v0x556788adc9e0_0 .net "addr_rt", 4 0, o0x7f305b15f078;  0 drivers
v0x556788adcaa0_0 .var "byteenable", 3 0;
o0x7f305b15f0d8 .functor BUFZ 4, C4<zzzz>; HiZ drive
v0x556788adcb80_0 .net "byteenable_ld", 3 0, o0x7f305b15f0d8;  0 drivers
o0x7f305b15f108 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788adccb0_0 .net "clk", 0 0, o0x7f305b15f108;  0 drivers
v0x556788adcd70_0 .var/i "i", 31 0;
o0x7f305b15f168 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788adce50_0 .net "link", 0 0, o0x7f305b15f168;  0 drivers
o0x7f305b15f198 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788adcf10_0 .net "rType", 0 0, o0x7f305b15f198;  0 drivers
v0x556788adcfd0_0 .var "read_data_1", 31 0;
v0x556788add0b0_0 .var "read_data_2", 31 0;
v0x556788add190 .array "register", 0 31, 31 0;
o0x7f305b15f828 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788add650_0 .net "rst", 0 0, o0x7f305b15f828;  0 drivers
o0x7f305b15f858 .functor BUFZ 2, C4<zz>; HiZ drive
v0x556788add710_0 .net "state", 1 0, o0x7f305b15f858;  0 drivers
v0x556788add7f0_0 .net "v0", 31 0, L_0x556788ade420;  1 drivers
v0x556788add8d0_0 .var "write_addr", 4 0;
v0x556788add9b0_0 .var "write_data", 31 0;
o0x7f305b15f918 .functor BUFZ 32, C4<zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>; HiZ drive
v0x556788addba0_0 .net "write_data_ALU", 31 0, o0x7f305b15f918;  0 drivers
o0x7f305b15f948 .functor BUFZ 32, C4<zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>; HiZ drive
v0x556788addc80_0 .net "write_data_PC", 31 0, o0x7f305b15f948;  0 drivers
o0x7f305b15f978 .functor BUFZ 32, C4<zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>; HiZ drive
v0x556788addd60_0 .net "write_data_ld", 31 0, o0x7f305b15f978;  0 drivers
v0x556788adde40_0 .var "write_enable", 0 0;
o0x7f305b15f9d8 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788addf00_0 .net "write_enable_ALU", 0 0, o0x7f305b15f9d8;  0 drivers
o0x7f305b15fa08 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788addfc0_0 .net "write_enable_PC", 0 0, o0x7f305b15fa08;  0 drivers
o0x7f305b15fa38 .functor BUFZ 1, C4<z>; HiZ drive
v0x556788ade080_0 .net "write_enable_ld", 0 0, o0x7f305b15fa38;  0 drivers
E_0x556788ab8b40 .event posedge, v0x556788adccb0_0;
v0x556788add190_0 .array/port v0x556788add190, 0;
v0x556788add190_1 .array/port v0x556788add190, 1;
E_0x556788ab8e00/0 .event anyedge, v0x556788adc900_0, v0x556788add190_0, v0x556788add190_1, v0x556788add190_2;
v0x556788add190_3 .array/port v0x556788add190, 3;
v0x556788add190_4 .array/port v0x556788add190, 4;
v0x556788add190_5 .array/port v0x556788add190, 5;
v0x556788add190_6 .array/port v0x556788add190, 6;
E_0x556788ab8e00/1 .event anyedge, v0x556788add190_3, v0x556788add190_4, v0x556788add190_5, v0x556788add190_6;
v0x556788add190_7 .array/port v0x556788add190, 7;
v0x556788add190_8 .array/port v0x556788add190, 8;
v0x556788add190_9 .array/port v0x556788add190, 9;
v0x556788add190_10 .array/port v0x556788add190, 10;
E_0x556788ab8e00/2 .event anyedge, v0x556788add190_7, v0x556788add190_8, v0x556788add190_9, v0x556788add190_10;
v0x556788add190_11 .array/port v0x556788add190, 11;
v0x556788add190_12 .array/port v0x556788add190, 12;
v0x556788add190_13 .array/port v0x556788add190, 13;
v0x556788add190_14 .array/port v0x556788add190, 14;
E_0x556788ab8e00/3 .event anyedge, v0x556788add190_11, v0x556788add190_12, v0x556788add190_13, v0x556788add190_14;
v0x556788add190_15 .array/port v0x556788add190, 15;
v0x556788add190_16 .array/port v0x556788add190, 16;
v0x556788add190_17 .array/port v0x556788add190, 17;
v0x556788add190_18 .array/port v0x556788add190, 18;
E_0x556788ab8e00/4 .event anyedge, v0x556788add190_15, v0x556788add190_16, v0x556788add190_17, v0x556788add190_18;
v0x556788add190_19 .array/port v0x556788add190, 19;
v0x556788add190_20 .array/port v0x556788add190, 20;
v0x556788add190_21 .array/port v0x556788add190, 21;
v0x556788add190_22 .array/port v0x556788add190, 22;
E_0x556788ab8e00/5 .event anyedge, v0x556788add190_19, v0x556788add190_20, v0x556788add190_21, v0x556788add190_22;
v0x556788add190_23 .array/port v0x556788add190, 23;
v0x556788add190_24 .array/port v0x556788add190, 24;
v0x556788add190_25 .array/port v0x556788add190, 25;
v0x556788add190_26 .array/port v0x556788add190, 26;
E_0x556788ab8e00/6 .event anyedge, v0x556788add190_23, v0x556788add190_24, v0x556788add190_25, v0x556788add190_26;
v0x556788add190_27 .array/port v0x556788add190, 27;
v0x556788add190_28 .array/port v0x556788add190, 28;
v0x556788add190_29 .array/port v0x556788add190, 29;
v0x556788add190_30 .array/port v0x556788add190, 30;
E_0x556788ab8e00/7 .event anyedge, v0x556788add190_27, v0x556788add190_28, v0x556788add190_29, v0x556788add190_30;
v0x556788add190_31 .array/port v0x556788add190, 31;
E_0x556788ab8e00/8 .event anyedge, v0x556788add190_31, v0x556788adc9e0_0, v0x556788addf00_0, v0x556788add710_0;
E_0x556788ab8e00/9 .event anyedge, v0x556788adcf10_0, v0x556788aaef70_0, v0x556788addba0_0, v0x556788ade080_0;
E_0x556788ab8e00/10 .event anyedge, v0x556788addd60_0, v0x556788adcb80_0, v0x556788addfc0_0, v0x556788addc80_0;
E_0x556788ab8e00/11 .event anyedge, v0x556788adce50_0;
E_0x556788ab8e00 .event/or E_0x556788ab8e00/0, E_0x556788ab8e00/1, E_0x556788ab8e00/2, E_0x556788ab8e00/3, E_0x556788ab8e00/4, E_0x556788ab8e00/5, E_0x556788ab8e00/6, E_0x556788ab8e00/7, E_0x556788ab8e00/8, E_0x556788ab8e00/9, E_0x556788ab8e00/10, E_0x556788ab8e00/11;
    .scope S_0x556788a7fcf0;
T_0 ;
Ewait_0 .event/or E_0x556788ab8e00, E_0x0;
    %wait Ewait_0;
    %load/vec4 v0x556788adc900_0;
    %pad/u 32;
    %cmpi/e 0, 0, 32;
    %flag_mov 8, 4;
    %jmp/0 T_0.0, 8;
    %pushi/vec4 0, 0, 32;
    %jmp/1 T_0.1, 8;
T_0.0 ; End of true expr.
    %load/vec4 v0x556788adc900_0;
    %pad/u 7;
    %ix/vec4 4;
    %load/vec4a v0x556788add190, 4;
    %jmp/0 T_0.1, 8;
 ; End of false expr.
    %blend;
T_0.1;
    %store/vec4 v0x556788adcfd0_0, 0, 32;
    %load/vec4 v0x556788adc9e0_0;
    %pad/u 32;
    %cmpi/e 0, 0, 32;
    %flag_mov 8, 4;
    %jmp/0 T_0.2, 8;
    %pushi/vec4 0, 0, 32;
    %jmp/1 T_0.3, 8;
T_0.2 ; End of true expr.
    %load/vec4 v0x556788adc9e0_0;
    %pad/u 7;
    %ix/vec4 4;
    %load/vec4a v0x556788add190, 4;
    %jmp/0 T_0.3, 8;
 ; End of false expr.
    %blend;
T_0.3;
    %store/vec4 v0x556788add0b0_0, 0, 32;
    %load/vec4 v0x556788addf00_0;
    %pad/u 32;
    %pushi/vec4 1, 0, 32;
    %cmp/e;
    %flag_get/vec4 4;
    %load/vec4 v0x556788add710_0;
    %pad/u 32;
    %pushi/vec4 2, 0, 32;
    %cmp/e;
    %flag_get/vec4 4;
    %and;
    %flag_set/vec4 8;
    %jmp/0xz  T_0.4, 8;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x556788adde40_0, 0, 1;
    %load/vec4 v0x556788adcf10_0;
    %flag_set/vec4 8;
    %jmp/0 T_0.6, 8;
    %load/vec4 v0x556788aaef70_0;
    %jmp/1 T_0.7, 8;
T_0.6 ; End of true expr.
    %load/vec4 v0x556788adc9e0_0;
    %jmp/0 T_0.7, 8;
 ; End of false expr.
    %blend;
T_0.7;
    %store/vec4 v0x556788add8d0_0, 0, 5;
    %load/vec4 v0x556788addba0_0;
    %store/vec4 v0x556788add9b0_0, 0, 32;
    %pushi/vec4 15, 0, 4;
    %store/vec4 v0x556788adcaa0_0, 0, 4;
    %jmp T_0.5;
T_0.4 ;
    %load/vec4 v0x556788ade080_0;
    %pad/u 32;
    %cmpi/e 1, 0, 32;
    %jmp/0xz  T_0.8, 4;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x556788adde40_0, 0, 1;
    %load/vec4 v0x556788adc9e0_0;
    %store/vec4 v0x556788add8d0_0, 0, 5;
    %load/vec4 v0x556788addd60_0;
    %store/vec4 v0x556788add9b0_0, 0, 32;
    %load/vec4 v0x556788adcb80_0;
    %store/vec4 v0x556788adcaa0_0, 0, 4;
    %jmp T_0.9;
T_0.8 ;
    %load/vec4 v0x556788addfc0_0;
    %pad/u 32;
    %cmpi/e 1, 0, 32;
    %jmp/0xz  T_0.10, 4;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x556788adde40_0, 0, 1;
    %load/vec4 v0x556788addc80_0;
    %store/vec4 v0x556788add9b0_0, 0, 32;
    %load/vec4 v0x556788adce50_0;
    %flag_set/vec4 8;
    %jmp/0 T_0.12, 8;
    %pushi/vec4 31, 0, 6;
    %jmp/1 T_0.13, 8;
T_0.12 ; End of true expr.
    %load/vec4 v0x556788aaef70_0;
    %pad/u 6;
    %jmp/0 T_0.13, 8;
 ; End of false expr.
    %blend;
T_0.13;
    %pad/u 5;
    %store/vec4 v0x556788add8d0_0, 0, 5;
    %pushi/vec4 15, 0, 4;
    %store/vec4 v0x556788adcaa0_0, 0, 4;
    %jmp T_0.11;
T_0.10 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x556788adde40_0, 0, 1;
T_0.11 ;
T_0.9 ;
T_0.5 ;
    %jmp T_0;
    .thread T_0, $push;
    .scope S_0x556788a7fcf0;
T_1 ;
    %wait E_0x556788ab8b40;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 32;
    %pushi/vec4 0, 0, 32;
    %cmp/ne;
    %flag_get/vec4 4;
    %load/vec4 v0x556788adde40_0;
    %pad/u 32;
    %pushi/vec4 1, 0, 32;
    %cmp/e;
    %flag_get/vec4 4;
    %and;
    %flag_set/vec4 8;
    %jmp/0xz  T_1.0, 8;
    %load/vec4 v0x556788adcaa0_0;
    %dup/vec4;
    %pushi/vec4 1, 0, 4;
    %cmp/u;
    %jmp/1 T_1.2, 6;
    %dup/vec4;
    %pushi/vec4 2, 0, 4;
    %cmp/u;
    %jmp/1 T_1.3, 6;
    %dup/vec4;
    %pushi/vec4 4, 0, 4;
    %cmp/u;
    %jmp/1 T_1.4, 6;
    %dup/vec4;
    %pushi/vec4 8, 0, 4;
    %cmp/u;
    %jmp/1 T_1.5, 6;
    %dup/vec4;
    %pushi/vec4 12, 0, 4;
    %cmp/u;
    %jmp/1 T_1.6, 6;
    %dup/vec4;
    %pushi/vec4 14, 0, 4;
    %cmp/u;
    %jmp/1 T_1.7, 6;
    %dup/vec4;
    %pushi/vec4 3, 0, 4;
    %cmp/u;
    %jmp/1 T_1.8, 6;
    %dup/vec4;
    %pushi/vec4 7, 0, 4;
    %cmp/u;
    %jmp/1 T_1.9, 6;
    %dup/vec4;
    %pushi/vec4 15, 0, 4;
    %cmp/u;
    %jmp/1 T_1.10, 6;
    %pushi/vec4 4294967295, 4294967295, 32;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    %jmp T_1.12;
T_1.2 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 8, 0, 2;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    %jmp T_1.12;
T_1.3 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 8, 8, 5;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 8, 0; part off
    %ix/load 5, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 4, 5;
    %jmp T_1.12;
T_1.4 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 8, 16, 6;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 16, 0; part off
    %ix/load 5, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 4, 5;
    %jmp T_1.12;
T_1.5 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 8, 24, 6;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 24, 0; part off
    %ix/load 5, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 4, 5;
    %jmp T_1.12;
T_1.6 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 16, 16, 6;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 16, 0; part off
    %ix/load 5, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 4, 5;
    %jmp T_1.12;
T_1.7 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 24, 8, 5;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 8, 0; part off
    %ix/load 5, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 4, 5;
    %jmp T_1.12;
T_1.8 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 16, 0, 2;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    %jmp T_1.12;
T_1.9 ;
    %load/vec4 v0x556788add9b0_0;
    %parti/s 24, 0, 2;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    %jmp T_1.12;
T_1.10 ;
    %load/vec4 v0x556788add9b0_0;
    %load/vec4 v0x556788add8d0_0;
    %pad/u 7;
    %ix/vec4 3;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    %jmp T_1.12;
T_1.12 ;
    %pop/vec4 1;
T_1.0 ;
    %load/vec4 v0x556788add650_0;
    %pad/u 32;
    %cmpi/e 1, 0, 32;
    %jmp/0xz  T_1.13, 4;
    %pushi/vec4 0, 0, 32;
    %store/vec4 v0x556788adcd70_0, 0, 32;
T_1.15 ;
    %load/vec4 v0x556788adcd70_0;
    %cmpi/s 32, 0, 32;
    %jmp/0xz T_1.16, 5;
    %pushi/vec4 0, 0, 32;
    %ix/getv/s 3, v0x556788adcd70_0;
    %ix/load 4, 0, 0; Constant delay
    %assign/vec4/a/d v0x556788add190, 0, 4;
    ; show_stmt_assign_vector: Get l-value for compressed += operand
    %load/vec4 v0x556788adcd70_0;
    %pushi/vec4 1, 0, 32;
    %add;
    %store/vec4 v0x556788adcd70_0, 0, 32;
    %jmp T_1.15;
T_1.16 ;
T_1.13 ;
    %jmp T_1;
    .thread T_1;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    "-";
    "regfile.v";
