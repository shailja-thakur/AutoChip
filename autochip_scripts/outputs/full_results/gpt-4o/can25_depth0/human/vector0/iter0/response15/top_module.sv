module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

    assign outv = vec;   // Output the same vector
    assign o0 = vec[0];  // Connect position 0 to o0
    assign o1 = vec[1];  // Connect position 1 to o1
    assign o2 = vec[2];  // Connect position 2 to o2

endmodule
