module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum; // 9-bit wire to handle potential overflow

    assign sum = a + b; // sum is the result of a + b
    assign s = sum[7:0]; // s is the 8 least significant bits of the sum

    // Overflow detection: if the sign bits of a and b are the same, but different from the sign bit of the sum
    assign overflow = ((a[7] == b[7]) && (a[7] != sum[7]));

endmodule
