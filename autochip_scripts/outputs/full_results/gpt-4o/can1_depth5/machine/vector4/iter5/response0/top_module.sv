module top_module (
    input [7:0] in,
    output [31:0] out
);

    assign out = { {24{in[7:0]}}, in }; // Replicate the 8-bit input to form 24 bits, then concatenate the original input.

endmodule
