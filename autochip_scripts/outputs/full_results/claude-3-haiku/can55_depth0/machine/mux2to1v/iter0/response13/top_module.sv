module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

    // Implement the multiplexer logic
    assign out = (sel == 1'b0) ? a : b;

endmodule
