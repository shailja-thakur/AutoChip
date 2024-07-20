module top_module (
    input [7:0] in,
    output [31:0] out
);
    // Replicate the 8-bit input 3 times and concatenate it with the original input
    assign out = { {3{in}}, in };
endmodule
