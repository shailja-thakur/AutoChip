module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        // Statement 1
        s[2] = s[2];                       // MSB of s is s[2]
        s[2] = x ^ s[2];                   // x XOR MSB of s
        s[0] = x;                          // Assign x to LSB of s
        
        // Statement 2
        s[1] = s[1];                       // Middle bit of s is s[1]
        s[1] = x & ~s[1];                  // x AND NOT middle bit of s
        
        // Statement 3
        s[0] = s[0];                       // LSB of s is s[0]
        s[0] = x | ~s[0];                  // x OR NOT LSB of s
    end

    always @(*) begin
        z = ~(s[2] | s[1] | s[0]);         // OR all bits of s, then NOT the result
    end

endmodule
