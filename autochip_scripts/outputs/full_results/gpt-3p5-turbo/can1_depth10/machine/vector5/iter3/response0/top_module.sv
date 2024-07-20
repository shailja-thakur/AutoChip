module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] inverse_a, inverse_b, inverse_c, inverse_d, inverse_e;

    assign inverse_a = ~a;
    assign inverse_b = ~b;
    assign inverse_c = ~c;
    assign inverse_d = ~d;
    assign inverse_e = ~e;

    assign out = ^{ {5{inverse_a}}, {5{inverse_b}}, {5{inverse_c}}, {5{inverse_d}}, {5{inverse_e}} } ^ { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

endmodule
