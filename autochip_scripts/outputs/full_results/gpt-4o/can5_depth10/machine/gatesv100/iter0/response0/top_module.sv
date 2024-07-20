module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
    wire [99:0] shifted_in;

    assign shifted_in = {in[98:0], 1'b0}; // Shift the input signal by one bit to the right

    assign out_both = in[99:1] & shifted_in[99:1]; // Generate 99-bit out_both signal
    assign out_any = in | shifted_in; // Generate 100-bit out_any signal
    assign out_different = in ^ {shifted_in[98:0], in[99]}; // Generate 100-bit out_different signal with first bit xor between in[0] and in[99]

endmodule
