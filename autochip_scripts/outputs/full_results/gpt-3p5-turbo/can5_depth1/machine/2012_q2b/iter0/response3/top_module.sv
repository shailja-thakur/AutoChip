module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
	// Define intermediate signals
	wire y1_intermediate;
	wire y3_intermediate;
	
	// Assignment of intermediate signals
	assign y1_intermediate = y[0] & w;
	assign y3_intermediate = (y[1] | y[2] | y[4] | y[5]) & (~w);
	
	// Output assignment
	assign Y1 = y1_intermediate;
	assign Y3 = y3_intermediate;
endmodule
