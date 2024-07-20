module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = { {24{in}}, in }; // Correctly replicate the 8-bit input 24 times for the first 24 bits, and then concatenate the original 8-bit input
endmodule
