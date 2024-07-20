module top_module(
	input [2:0] vec,
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

    assign outv = vec;   // Directly connect vec to outv
    assign o0 = vec[0];  // Connect least significant bit to o0
    assign o1 = vec[1];  // Connect middle bit to o1
    assign o2 = vec[2];  // Connect most significant bit to o2

endmodule
