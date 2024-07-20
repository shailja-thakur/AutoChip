module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] vec_a = 5'b00000;
    wire [4:0] vec_b = 5'b11111;

    assign out = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} } ^ { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

endmodule
