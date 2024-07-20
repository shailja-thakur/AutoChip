module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    wire [7:0] sum;
    
    // Logic to add the two inputs
    assign sum = a + b;
    
    // Assign the least significant 8 bits of the sum to the output
    always @(sum)
        s <= sum;
    
    // Check for overflow condition
    always @(sum, a, b)
    begin
        if ((a[7] == b[7]) && (s[7] != a[7]))
            overflow <= 1;
        else
            overflow <= 0;
    end
    
endmodule
