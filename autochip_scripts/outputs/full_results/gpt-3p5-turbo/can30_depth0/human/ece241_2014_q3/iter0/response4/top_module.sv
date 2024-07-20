module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	// Declare intermediate signals
	wire w1, w2, w3, w4, w5, w6;
	
	// Implement 2-to-1 multiplexers
	assign w1 = d & ~c;
	assign w2 = ~d & ~c;
	assign w3 = d & c;
	assign w4 = ~d & c;
	
	// Implement 4-to-1 multiplexer
	assign mux_in[0] = w1;
	assign mux_in[1] = w2;
	assign mux_in[2] = w3;
	assign mux_in[3] = w4;

endmodule
