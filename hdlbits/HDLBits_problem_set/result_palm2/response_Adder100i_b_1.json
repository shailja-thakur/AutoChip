module top_module (
    input [99:0] a,
    input [99:0] b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    generate
        for i in 0:99 generate
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(cin),
                .cout(cout[i]),
                .s(sum[i])
            );
        endgenerate
    endgenerate

endmodule