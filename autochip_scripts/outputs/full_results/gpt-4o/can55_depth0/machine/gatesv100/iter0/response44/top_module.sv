module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Generate the shifted version of the input signal
    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], in[99]};
    
    // Generate the out_both signal by performing a bit-wise AND operation between in and shifted_in
    assign out_both = in[98:0] & shifted_in[98:0];
    
    // Generate the out_any signal by performing a bit-wise OR operation between in and shifted_in
    assign out_any = in | shifted_in;
    
    // Generate the out_different signal by performing a bit-wise XOR operation between in and shifted_in
    assign out_different = in ^ shifted_in;

endmodule
