module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    for (int i = 0; i < 100; i++) begin
        bcd_fadd bcd_fadd_i (
            .a (a[i*4:i*4+3]),
            .b (b[i*4:i*4+3]),
            .cin (cin),
            .cout (cout[i*4]),
            .sum (sum[i*4:i*4+3])
        );
    end

endmodule