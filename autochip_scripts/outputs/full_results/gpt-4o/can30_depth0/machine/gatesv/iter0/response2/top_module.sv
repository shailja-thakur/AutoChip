module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

    // Bitwise AND operation
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation
    assign out_any = {in[2:0] | in[3:1], 1'b0}; // Need to extend it to 4-bit by adding 0 at LSB

    // Bitwise XOR operation
    assign out_different = in ^ {in[3:1], in[0]}; // Padding at LSB with in[0]

endmodule
