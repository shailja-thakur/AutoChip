module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	
	// Wire Declaration
	wire Y1;
	wire Y3;
	
	// AND gate for Y1
	assign Y1 = y[0] & w;
	
	// OR gate for Y3
	assign Y3 = (y[1] | y[2] | y[4] | y[5]) & !w;
	
endmodule
