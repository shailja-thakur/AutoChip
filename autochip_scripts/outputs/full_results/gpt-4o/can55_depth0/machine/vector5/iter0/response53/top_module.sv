module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [4:0] vec_a = {5{a}};
    wire [4:0] vec_b = {5{b}};
    wire [4:0] vec_c = {5{c}};
    wire [4:0] vec_d = {5{d}};
    wire [4:0] vec_e = {5{e}};

    wire [24:0] vector_1 = ~{vec_a, vec_b, vec_c, vec_d, vec_e};
    wire [24:0] vector_2 = {vec_a, vec_b, vec_c, vec_d, vec_e};

    assign out = vector_1 ^ vector_2;

endmodule
