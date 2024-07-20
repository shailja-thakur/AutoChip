module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vect1;
    wire [24:0] vect2;

    assign vect1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign vect2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign out = vect1 ^ vect2;

endmodule
