module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // 9 bits to accommodate overflow

    assign sum = a + b;
    assign s = sum[7:0]; // 8 least significant bits for the sum
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
