module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

    // Assign input vector to output vector
    assign outv = vec;
    
    // Assign individual bits to scalar outputs
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule
