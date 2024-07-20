module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

    // Intermediate signals for the AND gate outputs
    wire and1_out1, and1_out2;
    wire and2_out1, and2_out2;

    // AND gates for p1y
    assign and1_out1 = p1a & p1b & p1c;
    assign and1_out2 = p1d & p1e & p1f;
    
    // OR gate for p1y
    assign p1y = and1_out1 | and1_out2;

    // AND gates for p2y
    assign and2_out1 = p2a & p2b;
    assign and2_out2 = p2c & p2d;

    // OR gate for p2y
    assign p2y = and2_out1 | and2_out2;

endmodule
