module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    // Shift the input signal by one bit to the left
    assign in_shifted = {in[98:0], 1'b0};
    
    // Generate the out_both signal by bit-wise AND operation
    assign out_both = in[99:1] & in_shifted[99:1];
    
    // Generate the out_any signal by bit-wise OR operation
    assign out_any = in | in_shifted;
    
    // Generate the out_different signal by bit-wise XOR operation
    assign out_different = in ^ in_shifted;

endmodule
