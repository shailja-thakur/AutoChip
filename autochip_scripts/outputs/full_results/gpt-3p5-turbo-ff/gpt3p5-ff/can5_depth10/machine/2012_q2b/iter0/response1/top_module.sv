module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	// Declare intermediate signals
	wire b1, b2, b3;
  
	// Assign intermediate signals
	assign b1 = y[0] & w;
	assign b2 = y[1] | y[2] | y[4] | y[5];
	assign b3 = ~(w);
  
	// Assign output signals
	assign Y1 = b1;
	assign Y3 = b2 & b3;
endmodule
