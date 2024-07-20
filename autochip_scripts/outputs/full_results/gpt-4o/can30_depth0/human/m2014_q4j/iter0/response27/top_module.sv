module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
    wire [3:0] c; // carry bits

    // Full adder instances
    full_adder fa0 (x[0], y[0], 0, sum[0], c[0]);
    full_adder fa1 (x[1], y[1], c[0], sum[1], c[1]);
    full_adder fa2 (x[2], y[2], c[1], sum[2], c[2]);
    full_adder fa3 (x[3], y[3], c[2], sum[3], c[3]);

    assign sum[4] = c[3]; // overflow bit

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
