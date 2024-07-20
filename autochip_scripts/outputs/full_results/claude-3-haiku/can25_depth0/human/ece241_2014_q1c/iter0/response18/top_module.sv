module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two numbers
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the 8-bit result
assign s = sum[7:0];

// Detect overflow
// Overflow occurs when the most significant bit of the sum is different from both the most significant bits of the operands
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
