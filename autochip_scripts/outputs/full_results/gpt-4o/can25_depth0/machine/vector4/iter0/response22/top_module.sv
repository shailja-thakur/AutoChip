module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = {in, in, in, in}; // Concatenate the input 4 times (8-bit * 4 = 32-bit)
endmodule
