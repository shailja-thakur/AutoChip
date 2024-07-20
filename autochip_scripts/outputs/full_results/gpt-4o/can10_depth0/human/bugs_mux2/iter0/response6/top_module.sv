module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);

    assign out = (sel == 1'b0) ? a : b;

endmodule
