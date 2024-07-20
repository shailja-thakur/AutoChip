module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	// Intermediate signals for the Karnaugh map
	wire w0, w1, w2, w3, w4, w5, w6, w7;
	
	// Implementing the Karnaugh map using 2-to-1 multiplexers
	
	// Mux 1
	mux2_to_1 mux1 (.a(c), .b(d), .s(a), .y(w0));
	
	// Mux 2
	nor2 nor1 (.a(c), .b(d), .y(w1));
	mux2_to_1 mux2 (.a(nor1.y), .b(d), .s(a), .y(w2));
	
	// Mux 3
	nor2 nor2 (.a(c), .b(d), .y(w3));
	nor2 nor3 (.a(c), .b(nor2.y), .y(w4));
	mux2_to_1 mux3 (.a(w3), .b(nor3.y), .s(a), .y(w5));
	
	// Mux 4
	nor2 nor4 (.a(c), .b(d), .y(w6));
	nor2 nor5 (.a(c), .b(nor4.y), .y(w7));
	mux2_to_1 mux4 (.a(w6), .b(nor5.y), .s(a), .y(w8));
	
	// Connecting the outputs of the muxes to the mux_in outputs
	assign mux_in[0] = w0;
	assign mux_in[1] = w1;
	assign mux_in[2] = w2;
	assign mux_in[3] = w3;
	
endmodule
module mux2_to_1 (
	input a,
	input b,
	input s,
	output y
);
	
	assign y = (s & b) | (!s & a);
	
endmodule
module nor2 (
	input a,
	input b,
	output y
);
	
	assign y = !(a | b);
	
endmodule
