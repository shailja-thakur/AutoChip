module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Add the three input bits together
    assign out = in[2:0] + 3'b0;

endmodule
