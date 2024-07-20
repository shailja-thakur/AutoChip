module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;  // Declare a register to hold the sum, including the carry bit
    
    always @* begin
        sum = a + b;  // Add a and b, assign the result to sum
        s = sum[7:0];  // Assign the lower 8 bits of sum to s
        
        // Check for overflow by comparing the sign of a, b, and s
        overflow = (a[7] & b[7] & !s[7]) | (!a[7] & !b[7] & s[7]);
    end

endmodule
