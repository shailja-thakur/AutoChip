module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @(a or b or c or d or e) begin
    case ({a, b, c, d, e})
        // Case where c is 0
        5'b*_*_0_*_*: q <= b;
        // Case where c is 1
        5'b*_*_1_*_*: q <= e;
        // Case where c is 2
        5'b*_*_2_*_*: q <= a;
        // Case where c is 3
        5'b*_*_3_*_*: q <= d;
        // Case where c is 4
        5'b*_*_4_*_*: q <= f;
        // Case where c is 5
        5'b*_*_5_*_*: q <= f;
        // Case where c is 6
        5'b*_*_6_*_*: q <= f;
        // Case where c is 7
        5'b*_*_7_*_*: q <= f;
        // Case where c is 8
        5'b*_*_8_*_*: q <= f;
        // Case where c is 9
        5'b*_*_9_*_*: q <= f;
        // Case where c is a
        5'b*_*_a_*_*: q <= f;
        // Case where c is b
        5'b*_*_b_*_*: q <= f;
        // Case where c is c
        5'b*_*_c_*_*: q <= f;
        // Case where c is d
        5'b*_*_d_*_*: q <= f;
        // Case where c is e
        5'b*_*_e_*_*: q <= f;
        // Case where c is f
        5'b*_*_f_*_*: q <= f;
        // Default case
        default: q <= 0;
    endcase
end

endmodule
