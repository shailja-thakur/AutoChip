module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

always @(posedge clk) begin
    s[2] = s[2] ^ x;    // Statement 1: MSB of s is XOR'd with x, and LSB of s is assigned x
    s[1] = ~s[1] & x;   // Statement 2: Middle bit of s is assigned the AND of NOT(middle bit) and x
    s[0] = ~s[0] | x;   // Statement 3: LSB of s is assigned the OR of NOT(LSB) and x
end

assign z = ~(|s); // Assign the output z to the logical NOT of the OR of all bits of s

endmodule
