module top_module (
    input [7:0] in,
    output [31:0] out
);

assign out = {{24{in[7]}}, in}; // Replicate the sign bit (bit 7) 24 times, then concatenate with the original 8-bit number

endmodule
