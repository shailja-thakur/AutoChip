module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Add the two 8-bit numbers
wire [8:0] sum = $signed(a) + $signed(b);

// Store the result in the 8-bit output s
assign s = sum[7:0];

// Check for signed overflow
// Overflow occurs when the two operands have the same sign, 
// but the result has a different sign
assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
