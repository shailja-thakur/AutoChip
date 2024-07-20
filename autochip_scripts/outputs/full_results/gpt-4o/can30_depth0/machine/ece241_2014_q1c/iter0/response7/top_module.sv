module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum;      // Define a 9-bit wire to capture the carry-out as well
    
    assign sum = a + b;  // Perform the addition
    assign s = sum[7:0]; // Assign the lower 8 bits to the output s

    // Check for overflow: if the sign of a and b are the same but different from the sign of the result
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
