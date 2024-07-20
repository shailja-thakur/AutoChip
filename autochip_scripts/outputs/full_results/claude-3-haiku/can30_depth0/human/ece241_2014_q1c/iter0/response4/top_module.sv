module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

// Perform the addition
wire [8:0] sum = {1'b0, a} + {1'b0, b};

// Assign the output signal 's' to the lower 8 bits of the sum
assign s = sum[7:0];

// Detect overflow
// Overflow occurs if the sum of two positive numbers results in a negative number
// or if the sum of two negative numbers results in a positive number
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
