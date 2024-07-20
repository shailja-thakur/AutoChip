module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always_comb begin
    // Initialize min with the value of a
    min = a;
    
    // Compare min with b and update if b is smaller
    if (b < min) begin
        min = b;
    end
    
    // Compare min with c and update if c is smaller
    if (c < min) begin
        min = c;
    end
    
    // Compare min with d and update if d is smaller
    if (d < min) begin
        min = d;
    end
end

endmodule
