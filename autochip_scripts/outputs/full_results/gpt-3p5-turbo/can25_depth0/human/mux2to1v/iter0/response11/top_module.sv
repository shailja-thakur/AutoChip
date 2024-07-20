module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
    // 2-1 Multiplexer
    assign out = (sel == 0) ? a : b;
endmodule
