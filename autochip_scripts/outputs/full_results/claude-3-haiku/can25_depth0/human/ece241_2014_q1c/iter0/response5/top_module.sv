module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Perform the addition
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the output s
assign s = sum[7:0];

// Compute overflow
wire a_msb = a[7];
wire b_msb = b[7];
wire s_msb = s[7];
assign overflow = (a_msb & b_msb & ~s_msb) | (~a_msb & ~b_msb & s_msb);

endmodule
