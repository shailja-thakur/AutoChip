module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Internal wire declaration
	wire [1:0] ab;
	wire [1:0] cd;

	// Assigning values to internal wires 
	assign ab = {c, d};
	assign cd = {c, d};

	// Four-to-one multiplexer
	assign mux_in[0] = (ab == 2'b00) ? cd[0] : 1'b0;
	assign mux_in[1] = (ab == 2'b01) ? cd[0] : 1'b0;
	assign mux_in[2] = (ab == 2'b11) ? cd[1] : 1'b0;
	assign mux_in[3] = (ab == 2'b10) ? cd[0] : 1'b0;
	
endmodule
