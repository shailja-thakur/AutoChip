module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);
	// Generate Y2
	assign Y2 = y[1] & ~w;
  
  	// Generate Y4
	assign Y4 = y[6] & y[5] & y[3] & y[2] & w;
endmodule
