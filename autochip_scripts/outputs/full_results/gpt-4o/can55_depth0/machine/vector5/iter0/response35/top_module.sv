module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] input_bits = {a, b, c, d, e}; // 5 bit vector for inputs
    wire [24:0] first_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    wire [24:0] second_vector = {5{input_bits}};
    assign out = first_vector ^ second_vector;

endmodule
