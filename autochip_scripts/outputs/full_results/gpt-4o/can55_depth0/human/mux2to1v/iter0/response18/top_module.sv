module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

    // Use a ternary operator to select between a and b based on sel
    assign out = sel ? b : a;

endmodule
