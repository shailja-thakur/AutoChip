module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum; // Create a 9-bit wire to hold the sum including the carry out bit

assign sum = a + b; // Sum the inputs with a possible carry over
assign s = sum[7:0]; // Assign the 8 least significant bits to output s

// Check for overflow: it occurs when the sign of the output is different from the signs of both inputs
assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
