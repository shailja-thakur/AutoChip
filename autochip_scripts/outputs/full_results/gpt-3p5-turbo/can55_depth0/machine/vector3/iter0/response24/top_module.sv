module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    wire [4:0] a_concat_b;
    wire [4:0] c_concat_d;
    wire [4:0] e_concat_f;
    wire [4:0] a_concat_b_concat_c_concat_d;
    wire [4:0] w_concat_x;
    wire [4:0] y_concat_z;

    assign a_concat_b = {a, b};
    assign c_concat_d = {c, d};
    assign e_concat_f = {e, f};
    assign a_concat_b_concat_c_concat_d = {a, b, c_concat_d};
    assign w_concat_x = {a, b, c_concat_d};
    assign y_concat_z = {e_concat_f, 2'b11};

    assign w = {a_concat_b, a_concat_b_concat_c_concat_d};
    assign x = {a_concat_b, a_concat_b_concat_c_concat_d};
    assign y = {w_concat_x, y_concat_z};
    assign z = {w_concat_x, y_concat_z};

endmodule
