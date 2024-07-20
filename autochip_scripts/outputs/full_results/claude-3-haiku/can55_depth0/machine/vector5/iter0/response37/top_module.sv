module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] a_vector, b_vector, c_vector, d_vector, e_vector;
wire [24:0] vector1, vector2;

assign a_vector = {5{a}};
assign b_vector = {5{b}};
assign c_vector = {5{c}};
assign d_vector = {5{d}};
assign e_vector = {5{e}};

assign vector1 = ~{a_vector, b_vector, c_vector, d_vector, e_vector};
assign vector2 = {5{a,b,c,d,e}};

assign out = vector1 ^ vector2;

endmodule
