module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [4:0] a_vec = {5{a}};
    wire [4:0] b_vec = {5{b}};
    wire [4:0] c_vec = {5{c}};
    wire [4:0] d_vec = {5{d}};
    wire [4:0] e_vec = {5{e}};
    
    wire [24:0] first_vector = ~{a_vec, b_vec, c_vec, d_vec, e_vec};
    wire [24:0] second_vector = {a_vec, b_vec, c_vec, d_vec, e_vec};
    
    assign out = first_vector ^ second_vector;

endmodule
