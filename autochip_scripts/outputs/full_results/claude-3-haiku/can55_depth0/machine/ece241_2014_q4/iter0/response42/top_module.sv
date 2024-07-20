module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s is s[2]
    s[0] = x; // LSB of s is s[0]
    
    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s is s[1]
    
    // Statement 3
    s[0] = x | ~s[0]; // LSB of s is s[0]
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the inverse of the OR of all bits of s

endmodule
