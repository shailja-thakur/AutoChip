module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @* begin
        // Initially assign the value of 'a' to 'min'
        min = a;
        
        // Compare 'min' with 'b'
        if (b < min)
            min = b;
        
        // Compare 'min' with 'c'
        if (c < min)
            min = c;
        
        // Compare 'min' with 'd'
        if (d < min)
            min = d;
    end
endmodule
