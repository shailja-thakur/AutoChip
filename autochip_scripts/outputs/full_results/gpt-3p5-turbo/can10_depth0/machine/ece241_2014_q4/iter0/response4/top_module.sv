module top_module(
    input clk,
    input x,
    output reg z
);
    
    reg [2:0] s = 3'b0; // Define register s as 3 bits with initial value 0
    
    always @(posedge clk) begin
        // Statement 1
        s[2] <= s[1] ^ x; // XOR operator applied to MSB of s and input x
        s[0] <= x; // Assign input x to LSB of s
        
        // Statement 2
        s[1] <= ~s[1] & x; // NOT operator applied to middle bit of s and AND operation with input x
        
        // Statement 3
        s[0] <= ~s[0] | x; // NOT operator applied to LSB of s and OR operation with input x
    end
    
    // Assign output z
    assign z = ~(|s); // NOT operator applied to output of OR operation on all bits of s
    
endmodule
