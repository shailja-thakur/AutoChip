module top_module (
    input signed [7:0] a,
    input signed [7:0] b,
    output signed [7:0] s,
    output overflow
);

// Assuming 2's complement addition of a and b to produce s
// a and b are signed 8-bit numbers

// Intermediate variables
wire signed [8:0] sum;
wire sign_a;
wire sign_b;

// Logic to determine sign of a and b
assign sign_a = a[7];
assign sign_b = b[7];

// Adding a and b
// if a and b have the same sign, there can be an overflow if the sign of s is different
// if a and b have different signs, there cannot be an overflow
// if a and b have opposite signs and the sign of s is the same as that of a, there can be an overflow
assign sum = a + b;

// Assigning output s
assign s = sum[7:0];

// Determining overflow
assign overflow = ((sign_a & sign_b & ~sum[8]) | (~sign_a & ~sign_b & sum[8]));

endmodule
