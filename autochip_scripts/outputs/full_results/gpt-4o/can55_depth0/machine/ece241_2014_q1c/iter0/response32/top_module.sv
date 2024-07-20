module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum; // a 9-bit wire to store the sum including carry-out

assign sum = a + b;
assign s = sum[7:0]; // 8 least significant bits
assign overflow = (~a[7] & ~b[7] & sum[8]) | (a[7] & b[7] & ~sum[8]); // detect overflow

endmodule
