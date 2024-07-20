module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two 8-bit 2's complement numbers
wire [8:0] sum = {a[7], a} + {b[7], b};

// Assign the sum output
assign s = sum[7:0];

// Compute the overflow condition
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
