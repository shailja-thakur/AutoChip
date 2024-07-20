module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] v1, v2;

    assign v1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign v2 = {5{a, b, c, d, e}};
    assign out = v1 ^ v2;

endmodule
