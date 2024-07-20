module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

    assign outv = vec;    // Output the same vector
    assign o0 = vec[0];   // Split the vector into separate 1-bit outputs
    assign o1 = vec[1];
    assign o2 = vec[2];

endmodule
