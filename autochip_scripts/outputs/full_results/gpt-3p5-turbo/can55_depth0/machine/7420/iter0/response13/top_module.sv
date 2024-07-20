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

	// AND operation for inputs p1a, p1b, p1c, and p1d
	and #(4) and1(p1y, p1a, p1b, p1c, p1d);
	
	// AND operation for inputs p2a, p2b, p2c, and p2d
	and #(4) and2(p2y, p2a, p2b, p2c, p2d);
	
	// Inverting the p1y output
	not not1(p1y_inverted, p1y);
	
	// Inverting the p2y output
	not not2(p2y_inverted, p2y);
	
	// Assigning the inverted outputs to p1y and p2y
	assign p1y = p1y_inverted;
	assign p2y = p2y_inverted;
	
endmodule
