module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    add16 add1 (
        input [15:0] a_low,
        input [15:0] b_low,
        input cin,
        output [15:0] sum_low,
        output cout
    );

    add16 add2 (
        input [15:0] a_high,
        input [15:0] b_high,
        input cout_low,
        output [15:0] sum_high,
        output cout
    );

    assign sum = sum_low + sum_high;

endmodule