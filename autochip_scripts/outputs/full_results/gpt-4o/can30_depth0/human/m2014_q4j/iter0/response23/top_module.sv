module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] carry;
    wire [4:0] full_sum;

    // Using full adder modules for each bit calculation
    full_adder fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .sum(full_sum[0]),
        .cout(carry[0])
    );

    full_adder fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(carry[0]),
        .sum(full_sum[1]),
        .cout(carry[1])
    );

    full_adder fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(carry[1]),
        .sum(full_sum[2]),
        .cout(carry[2])
    );

    full_adder fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(carry[2]),
        .sum(full_sum[3]),
        .cout(full_sum[4])
    );

    assign sum = full_sum;

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
