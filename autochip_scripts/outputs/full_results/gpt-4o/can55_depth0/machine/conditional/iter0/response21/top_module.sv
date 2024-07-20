module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @* begin
        min = a; // Start by assuming 'a' is the minimum value
        
        if (b < min) 
            min = b; // If 'b' is smaller, update min
        if (c < min) 
            min = c; // If 'c' is smaller, update min
        if (d < min) 
            min = d; // If 'd' is smaller, update min
    end

endmodule
