module top_module (
    input [7:0] in,
    output [31:0] out );

    // Replicate the sign bit 24 times
    logic [31:0] replicate_sign_bit = 1'b1 << 7;

    // Concatenate the sign bit and the 8-bit number
    out = { replicate_sign_bit, in };

endmodule