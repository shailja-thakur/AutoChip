module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow    // Changed output to output reg
);

always @* begin
    reg [7:0] sum;
    sum = a + b;
    s = sum[7:0];         // Removed the wire declaration and assigned s directly to the 8 least significant bits of the sum
    if (a[7] == b[7] && sum[7] != a[7])   // Added missing parentheses in the condition
        overflow = 1;
    else
        overflow = 0;
end

endmodule
