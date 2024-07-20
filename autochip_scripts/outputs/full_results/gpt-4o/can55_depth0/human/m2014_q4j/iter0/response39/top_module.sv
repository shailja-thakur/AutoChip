module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    
    wire c1, c2, c3, c4;
    
    // Full adder for bit 0
    full_adder fa0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .sum(sum[0]),
        .cout(c1)
    );
    
    // Full adder for bit 1
    full_adder fa1 (
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );
    
    // Full adder for bit 2
    full_adder fa2 (
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );
    
    // Full adder for bit 3
    full_adder fa3 (
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(c4)
    );

    // The overall carry-out is the overflow bit
    assign sum[4] = c4;

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign {cout, sum} = a + b + cin;
endmodule
