module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );

    wire [4:0] a_concat;
    wire [4:0] b_concat;
    wire [4:0] c_concat;
    wire [4:0] d_concat;
    wire [4:0] e_concat;
    wire [4:0] f_concat;

    assign a_concat = a | b | c | d | e | f;
    assign b_concat = a_concat | 1;
    assign c_concat = b_concat | 1;
    assign d_concat = c_concat | 1;
    assign e_concat = d_concat | 1;
    assign f_concat = e_concat | 1;

    assign w = a_concat;
    assign x = b_concat;
    assign y = c_concat;
    assign z = d_concat;

endmodule