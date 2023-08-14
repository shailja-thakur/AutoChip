module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    full_adder fa1 (a[0], b[0], cin, sum[0], cout[0]);
    full_adder fa2 (a[1], b[1], cout[0], sum[1], cout[1]);
    full_adder fa3 (a[2], b[2], cout[1], sum[2], cout[2]);

endmodule