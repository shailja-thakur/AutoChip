module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a 4-bit wide, 256-to-1 multiplexer
	// The 256 4-bit inputs are all packed into a single 1024-bit input vector
	// sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.
	
	// Create intermediate signals
	reg [3:0] mux_input [0:255];
	assign mux_out = mux_input[sel];
	
	// Unpack the input vector into individual 4-bit inputs
	genvar i;
	generate
		for (i = 0; i < 256; i=i+1) begin
			assign mux_input[i] = in[i*4 +: 4];
		end
	endgenerate
	
	// Create the multiplexer
	assign out = mux_out;
	
endmodule
