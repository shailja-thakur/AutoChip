module top_module (
    input [99:0] a,
    input [99:0] b,
    input wire sel,
    output [99:0] out
);

    assign out = sel ? b : a;

endmodule
