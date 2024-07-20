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

    // Intermediate signal for p1y AND operation
    wire p1y_intermediate;
    and(p1y_intermediate, p1a, p1b, p1c, p1d);
    not(p1y, p1y_intermediate);
    
    // Intermediate signal for p2y AND operation
    wire p2y_intermediate;
    and(p2y_intermediate, p2a, p2b, p2c, p2d);
    not(p2y, p2y_intermediate);

endmodule
