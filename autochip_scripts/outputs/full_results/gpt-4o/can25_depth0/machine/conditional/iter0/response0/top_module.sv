module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

    always @(*) begin
        min = a; // Start with a as the minimum value
        
        if (b < min) begin
            min = b; // Update min if b is less than min
        end
        
        if (c < min) begin
            min = c; // Update min if c is less than min
        end
        
        if (d < min) begin
            min = d; // Update min if d is less than min
        end
    end

endmodule
