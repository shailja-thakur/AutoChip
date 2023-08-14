module top_module(
    input [99:0] a,
    input [99:0] b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

    generate
        for (i = 0; i < 100; i++) begin
            wire carry_in = (i == 0) ? cin : cout[i - 1];
            wire sum_i = a[i] + b[i] + carry_in;
            wire carry_out = (sum_i >= 2's complement(100));

            full_adder fa_i (
                .a(a[i]),
                .b(b[i]),
                .cin(carry_in),
                .cout(carry_out),
                .sum(sum_i)
            );
        end
    endgenerate

    assign cout = cout[99];
    assign sum = sum[99];

endmodule