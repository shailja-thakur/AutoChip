module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Implement the K-map using 2-to-1 multiplexers

// Intermediate signals for the first level of 2-to-1 multiplexers
wire cd00, cd01, cd11, cd10;
assign cd00 = ~c & ~d;
assign cd01 = c & ~d;
assign cd11 = c & d;
assign cd10 = ~c & d;

// Intermediate signals for the second level of 2-to-1 multiplexers
wire ab00, ab01, ab11, ab10;
assign ab00 = ~a & ~b;
assign ab01 = a & ~b;
assign ab11 = a & b;
assign ab10 = ~a & b;

// Connect the intermediate signals to the inputs of the 4-to-1 multiplexer
assign mux_in[0] = ab00 ? cd00 : cd10;
assign mux_in[1] = ab01 ? cd01 : cd00;
assign mux_in[2] = ab11 ? cd11 : cd01;
assign mux_in[3] = ab10 ? cd10 : cd11;

endmodule
