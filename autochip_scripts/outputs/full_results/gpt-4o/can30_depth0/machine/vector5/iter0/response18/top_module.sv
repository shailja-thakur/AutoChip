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
    
    wire [24:0] first_vector = {vec_a, vec_b, vec_c, vec_d, vec_e};
    wire [24:0] second_vector = {5{a, b, c, d, e}};
    wire [24:0] not_first_vector = ~first_vector;
    
    assign out = not_first_vector ^ second_vector;

endmodule
