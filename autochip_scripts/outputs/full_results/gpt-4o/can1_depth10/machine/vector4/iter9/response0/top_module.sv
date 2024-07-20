module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = { {24{in[7]}}, in }; // Replicate only the MSB of input to fill the first 24 bits, then concatenate the entire 8-bit input.
endmodule
