module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire MUX_2_1_1;
wire MUX_2_1_2;
wire MUX_2_1_3;
wire MUX_2_1_4;

// Implementing the 2-to-1 multiplexers
mux_2to1 mux1 (.a(c), .b(d), .s(MUX_2_1_1), .y(mux_in[0]));
mux_2to1 mux2 (.a(c), .b(d), .s(MUX_2_1_2), .y(mux_in[1]));
mux_2to1 mux3 (.a(c), .b(d), .s(MUX_2_1_3), .y(mux_in[2]));
mux_2to1 mux4 (.a(c), .b(d), .s(MUX_2_1_4), .y(mux_in[3]));

// Implementing the 4-to-1 multiplexer
mux_4to1 mux5 (.a(mux_in[0]), .b(mux_in[1]), .c(mux_in[2]), .d(mux_in[3]), .s({a, b}), .y(output));

endmodule
module mux_2to1 (
    input a,
    input b,
    input s,
    output y
);

assign y = s ? b : a;

endmodule
module mux_4to1 (
    input a,
    input b,
    input c,
    input d,
    input [1:0] s,
    output y
);

assign y = (s == 2'd00) ? a : (s == 2'd01) ? b : (s == 2'd10) ? c : d;

endmodule
