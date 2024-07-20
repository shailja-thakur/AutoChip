module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire t1, t2, t3, t4, t5;
wire [3:0] t6, t7, t8, t9;

// Implementing the K-map using 2-to-1 multiplexers
mux2_to_1 mux1 (.a(c), .b(d), .sel(a), .out(t1));
mux2_to_1 mux2 (.a(~d), .b(~c), .sel(a), .out(t2));
mux2_to_1 mux3 (.a(c), .b(~d), .sel(a), .out(t3));
mux2_to_1 mux4 (.a(~c), .b(d), .sel(a), .out(t4));
mux2_to_1 mux5 (.a(b), .b(~c), .sel(a), .out(t5));

// Constructing the 4-to-1 multiplexer using the outputs of the 2-to-1 multiplexers
mux4_to_1 mux6 (.a(t2), .b(t4), .c(t3), .d(t5), .sel(b), .out(t6));
mux4_to_1 mux7 (.a(t1), .b(t2), .c(t5), .d(t4), .sel(b), .out(t7));
mux4_to_1 mux8 (.a(t1), .b(t3), .c(t4), .d(t2), .sel(b), .out(t8));
mux4_to_1 mux9 (.a(t2), .b(t3), .c(t5), .d(t1), .sel(b), .out(t9));

// Assigning the outputs of the 4-to-1 multiplexer to the mux_in outputs
assign mux_in[0] = t6[0];
assign mux_in[1] = t7[0];
assign mux_in[2] = t8[0];
assign mux_in[3] = t9[0];

endmodule
module mux2_to_1 (
    input a,
    input b,
    input sel,
    output out
);

// 2-to-1 multiplexer implementation
assign out = (sel == 0) ? a : b;

endmodule
module mux4_to_1 (
    input a,
    input b,
    input c,
    input d,
    input sel,
    output out
);

// 4-to-1 multiplexer implementation
assign out = (sel == 00) ? a : (sel == 01) ? b : (sel == 10) ? c : d;

endmodule
