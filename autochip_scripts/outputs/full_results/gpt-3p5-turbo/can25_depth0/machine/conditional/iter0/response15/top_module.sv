module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always_comb begin
    min = a; // Assign the value of a to min
    
    if (b < min) begin
        min = b; // Update min with the value of b if b is less than min
    end
    
    if (c < min) begin
        min = c; // Update min with the value of c if c is less than min
    end
    
    if (d < min) begin
        min = d; // Update min with the value of d if d is less than min
    end
end

endmodule
