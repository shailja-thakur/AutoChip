module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

// Create a 256-to-1 multiplexer module
module mux256to1 (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

// Declare internal wires and registers
wire [7:0] sel_idx;
wire [3:0] out_mux;

reg [3:0] in_sel0;
reg [3:0] in_sel1;
reg [3:0] in_sel2;
reg [3:0] in_sel3;
reg [3:0] in_sel4;
reg [3:0] in_sel5;
reg [3:0] in_sel6;
reg [3:0] in_sel7;

// Select the 4-bit inputs based on the select signal
always @*
begin
    case(sel)
        0: sel_idx = 0;
        1: sel_idx = 4;
        2: sel_idx = 8;
        3: sel_idx = 12;
        4: sel_idx = 16;
        5: sel_idx = 20;
        6: sel_idx = 24;
        7: sel_idx = 28;
        default: sel_idx = 0;
    endcase
    
    in_sel0 = in[sel_idx + 3 : sel_idx];
    in_sel1 = in[sel_idx + 7 : sel_idx + 4];
    in_sel2 = in[sel_idx + 11 : sel_idx + 8];
    in_sel3 = in[sel_idx + 15 : sel_idx + 12];
    in_sel4 = in[sel_idx + 19 : sel_idx + 16];
    in_sel5 = in[sel_idx + 23 : sel_idx + 20];
    in_sel6 = in[sel_idx + 27 : sel_idx + 24];
    in_sel7 = in[sel_idx + 31 : sel_idx + 28];
end

// Instantiate the 256-to-1 multiplexer module
mux256to1 mux (
    .in({in_sel7, in_sel6, in_sel5, in_sel4, in_sel3, in_sel2, in_sel1, in_sel0}),
    .sel(sel[2:0]),
    .out(out_mux)
);

// Output the selected 4-bit input
assign out = out_mux;

endmodule
module mux256to1 (
    input [255:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

// Select the output based on the select signal
always @*
begin
    case(sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        3: out = in[15:12];
        4: out = in[19:16];
        5: out = in[23:20];
        6: out = in[27:24];
        7: out = in[31:28];
        default: out = 0;
    endcase
end

endmodule
