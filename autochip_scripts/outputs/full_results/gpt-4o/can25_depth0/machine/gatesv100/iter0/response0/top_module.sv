module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input signal by one bit
    wire [99:0] in_shifted = {in[98:0], in[99]}; // Shift left, with the last bit wrapped around

    // Generate the out_both signal (bit-wise AND operation)
    assign out_both = in[98:0] & in[99:1];

    // Generate the out_any signal (bit-wise OR operation)
    assign out_any = in | in_shifted;

    // Generate the out_different signal (bit-wise XOR operation)
    assign out_different = in ^ in_shifted;

endmodule
