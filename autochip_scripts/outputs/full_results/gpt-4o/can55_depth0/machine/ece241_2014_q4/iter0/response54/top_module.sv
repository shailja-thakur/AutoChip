module top_module (
    input clk,
    input x,
    output z
);
    
    reg [2:0] s = 3'b000; // Register definition with initial value 0
    
    always @(posedge clk) begin
        // Statement 1
        s[2] <= x ^ s[2]; // MSB operation
        s[0] <= x; // LSB assignment
        
        // Statement 2
        s[1] <= x & ~s[1]; // Middle bit operation
        
        // Statement 3
        s[0] <= x | ~s[0]; // LSB operation
    end
    
    assign z = ~(|s); // Assigning output z

endmodule
