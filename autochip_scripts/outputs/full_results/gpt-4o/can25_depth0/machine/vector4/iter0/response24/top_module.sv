module top_module (
    input [7:0] in,
    output [31:0] out
);
    // Replicate the 8-bit input 24 times and concatenate with the original 8-bit input
    assign out = {24{in}, in};
endmodule
