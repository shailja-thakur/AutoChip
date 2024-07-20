module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = { {24{in}}, in }; // Replicating the 8-bit input 24 times and concatenating with the original 8-bit input
endmodule
