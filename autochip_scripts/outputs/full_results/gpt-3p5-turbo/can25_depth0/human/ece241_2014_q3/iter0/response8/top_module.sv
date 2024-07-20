module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [3:0] a0, a1, a2, a3; // Intermediate wires for 2-to-1 multiplexers

// Intermediate 2-to-1 multiplexers
mux2to1 mux0 (.a(c), .b(d), .sel(a[0]), .out(a0[0]));  // cd=00
mux2to1 mux1 (.a(~c), .b(d), .sel(a[1]), .out(a1[0])); // cd=01
mux2to1 mux2 (.a(~c), .b(~d), .sel(a[2]), .out(a2[0])); // cd=11
mux2to1 mux3 (.a(c), .b(~d), .sel(a[3]), .out(a3[0])); // cd=10

// 4-to-1 multiplexer
mux4to1 mux4 (.a(a0), .b(a1), .c(a2), .d(a3), .sel({a[1], a[0]}), .out(mux_in));

endmodule
