module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    bcd_fadd bcd_fadd_0 (
        input [3:0] a_0,
        input [3:0] b_0,
        input     cin_0,
        output   cout_0,
        output [3:0] sum_0 );

    bcd_fadd bcd_fadd_1 (
        input [3:0] a_1,
        input [3:0] b_1,
        input     cin_1,
        output   cout_1,
        output [3:0] sum_1 );

    bcd_fadd bcd_fadd_2 (
        input [3:0] a_2,
        input [3:0] b_2,
        input     cin_2,
        output   cout_2,
        output [3:0] sum_2 );

    bcd_fadd bcd_fadd_3 (
        input [3:0] a_3,
        input [3:0] b_3,
        input     cin_3,
        output   cout_3,
        output [3:0] sum_3 );

    assign cout = bcd_fadd_0.cout + bcd_fadd_1.cout + bcd_fadd_2.cout + bcd_fadd_3.cout;
    assign sum = bcd_fadd_0.sum + bcd_fadd_1.sum + bcd_fadd_2.sum + bcd_fadd_3.sum;

endmodule