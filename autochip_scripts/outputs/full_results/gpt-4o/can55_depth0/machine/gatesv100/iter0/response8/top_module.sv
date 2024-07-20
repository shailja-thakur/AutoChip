module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    // Shift the input signal by one bit to get the second signal
    assign shifted_in = {in[98:0], 1'b0};
    
    // Generate out_both by performing a bit-wise AND operation between in and shifted_in (excluding the last bit)
    assign out_both = in[99:1] & shifted_in[99:1];
    
    // Generate out_any by performing a bit-wise OR operation between in and shifted_in
    assign out_any = in | shifted_in;

    // Generate out_different by performing a bit-wise XOR operation between in and shifted_in
    assign out_different = in ^ shifted_in;
    
endmodule
