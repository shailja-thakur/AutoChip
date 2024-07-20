module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	// instantiate logic gates
	and #(4) and1(p1a, p1b, p1c, p1d, p1y);
	and #(4) and2(p2a, p2b, p2c, p2d, p2y);
	
endmodule
module and #(parameter N = 2)(
	input [N-1:0] a,
	output y
);
	genvar i;
	wire [N-1:0] temp = {a[N-1], a};

	assign y = ~|temp;

endmodule
