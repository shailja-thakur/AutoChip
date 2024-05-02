module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    generate
        for i in 0:99 generate
            bcd_fadd u(a[i*4:i*4+3], b[i*4:i*4+3], cin[i], cout[i*4+3], sum[i*4:i*4+3]);
        endgenerate
    endgenerate

endmodule