module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum;  // 9-bit wire to hold the sum to accommodate overflow

    assign sum = a + b;  // Summing the two 8-bit numbers

    assign s = sum[7:0];  // Assigning the least significant 8 bits to the output

    assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]); // Checking for overflow

endmodule
