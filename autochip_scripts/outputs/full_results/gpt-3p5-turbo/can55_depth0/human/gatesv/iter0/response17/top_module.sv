module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    wire both_0, both_1, both_2;
    wire any_1, any_2, any_3;
    wire different_0, different_1, different_2, different_3;

    assign both_0 = in[0] & in[3];
    assign both_1 = in[1] & in[0];
    assign both_2 = in[2] & in[1];

    assign any_1 = in[1] | in[2];
    assign any_2 = in[2] | in[3];
    assign any_3 = in[3] | in[0];

    assign different_0 = in[0] != in[3];
    assign different_1 = in[1] != in[0];
    assign different_2 = in[2] != in[1];
    assign different_3 = in[3] != in[2];

    assign out_both = {both_2, both_1, both_0};
    assign out_any = {any_3, any_2, any_1};
    assign out_different = {different_3, different_2, different_1, different_0};

endmodule
