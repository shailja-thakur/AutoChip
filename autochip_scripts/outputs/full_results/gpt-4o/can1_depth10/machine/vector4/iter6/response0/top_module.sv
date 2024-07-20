module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = {in, in, in, in}; // Replicate the input 4 times, not 24 times to match the 32-bit output width
endmodule
