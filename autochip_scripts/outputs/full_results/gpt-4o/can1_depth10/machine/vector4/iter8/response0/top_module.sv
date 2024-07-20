module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = { {3{in}}, in }; // Replicating 8-bit input 3 times for 24 bits and then concatenating the original 8-bit input
endmodule
