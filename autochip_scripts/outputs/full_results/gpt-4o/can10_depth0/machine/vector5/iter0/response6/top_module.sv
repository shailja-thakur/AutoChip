module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [4:0] a_rep = {5{a}};
    wire [4:0] b_rep = {5{b}};
    wire [4:0] c_rep = {5{c}};
    wire [4:0] d_rep = {5{d}};
    wire [4:0] e_rep = {5{e}};

    wire [24:0] vec1 = ~{a_rep, b_rep, c_rep, d_rep, e_rep};
    wire [24:0] vec2 = {a_rep, b_rep, c_rep, d_rep, e_rep};

    assign out = vec1 ^ vec2;

endmodule
