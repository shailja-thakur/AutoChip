module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Second input signal that is a shifted version of the first input signal
    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], in[99]};  // Shifting by 1 bit to the right, wrapping around

    // Generate out_both by performing bit-wise AND operation between two input signals
    assign out_both = in[99:1] & shifted_in[99:1];

    // Generate out_any by performing bit-wise OR operation between two input signals
    assign out_any = in | shifted_in;
    
    // Generate out_different by performing bit-wise XOR operation between two input signals
    assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];
    assign out_different[0] = in[0] ^ shifted_in[99];

endmodule
