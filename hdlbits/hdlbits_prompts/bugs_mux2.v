// This 8-bit wide 2-to-1 multiplexer doesn't work. Fix the bug(s).

module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output out  );

    assign out = (~sel & a) | (sel & b);

endmodule
