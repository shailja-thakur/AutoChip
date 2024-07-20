module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    // Shift the input signal by 1-bit to the right
    assign in_shifted = {1'b0, in[99:1]};

    // Generate the out_both signal by performing a bit-wise AND operation between in and the shifted in
    assign out_both = in[98:0] & in_shifted[98:0];

    // Generate the out_any signal by performing a bit-wise OR operation between in and the shifted in
    assign out_any = in | in_shifted;

    // Generate the out_different signal
    assign out_different = in ^ {in[0], in_shifted[99:1]};

endmodule
