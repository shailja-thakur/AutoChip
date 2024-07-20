module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    reg [8:0] sum; // Register to hold the sum
    
    always @(*) begin
        sum = a + b; // Compute the sum of a and b
        s = sum[7:0]; // Assign the lower 8 bits to s
        
        if (sum[8] == 1) // Check if the MSB is 1
            overflow = 1; // Set overflow to 1 if there's overflow
        else
            overflow = 0; // Set overflow to 0 if there's no overflow
    end
endmodule
