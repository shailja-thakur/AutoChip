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
	// Define intermediate wires for the AND operations
	wire p1and_result;
	wire p2and_result;

	// Implement the AND gates
	and(p1and_result, p1a, p1b, p1c, p1d);
	and(p2and_result, p2a, p2b, p2c, p2d);

	// Implement the inverted outputs
	assign p1y = ~p1and_result;
	assign p2y = ~p2and_result;
endmodule
