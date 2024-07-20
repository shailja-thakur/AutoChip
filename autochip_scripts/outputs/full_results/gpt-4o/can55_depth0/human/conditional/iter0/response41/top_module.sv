module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);
    always @(*) begin
        // Find the minimum of the first two numbers
        if (a < b)
            min = a;
        else
            min = b;
        
        // Compare the current minimum with the third number
        if (c < min)
            min = c;
        
        // Finally, compare the current minimum with the fourth number
        if (d < min)
            min = d;
    end
endmodule
