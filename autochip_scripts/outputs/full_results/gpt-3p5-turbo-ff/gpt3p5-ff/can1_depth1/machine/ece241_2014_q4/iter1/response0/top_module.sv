module top_module (
    input clk,
    input x,
    output reg z
);
    
    reg [2:0] s = 3'b0; // Define register s as 3 bits and initialize it to 0
    
    always @(posedge clk) begin
        // Statement 1
        s[2] <= s[1] ^ x; // Exclusive OR operation between x and MSB of s
        s[0] <= x; // Assign x to LSB of s
        
        // Statement 2
        s[1] <= ~s[1] & x; // Bitwise NOT operation on the middle bit of s and AND operation with x
        
        // Statement 3
        s[0] <= ~s[0] | x; // Bitwise NOT operation on the LSB of s and OR operation with x
        
        // Assign output z
        z <= ~(|s); // Bitwise OR operation on all bits of s and then bitwise NOT operation
    end
    
endmodule
