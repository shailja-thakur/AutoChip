module top_module (
    input [2:0] in,
    output [1:0] out
);
    // Summing the 3 input bits
    assign out = in[0] + in[1] + in[2];
endmodule
