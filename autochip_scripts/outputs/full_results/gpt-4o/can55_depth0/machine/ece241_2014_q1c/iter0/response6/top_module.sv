module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum; // Use 9-bit wire to capture the overflow bit

    assign sum = a + b;
    assign s = sum[7:0];
    assign overflow = (a[7] == b[7]) & (sum[8] != a[7]);

endmodule
