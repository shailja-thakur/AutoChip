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
    // Intermediate wires to hold the AND results before inversion
    wire and1_result;
    wire and2_result;

    // AND operations
    assign and1_result = p1a & p1b & p1c & p1d;
    assign and2_result = p2a & p2b & p2c & p2d;

    // Inverted outputs
    assign p1y = ~and1_result;
    assign p2y = ~and2_result;

endmodule
