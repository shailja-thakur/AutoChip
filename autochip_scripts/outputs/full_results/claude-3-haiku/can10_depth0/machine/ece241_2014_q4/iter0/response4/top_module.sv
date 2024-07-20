module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s, initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = s[2] ^ x; // Exclusive OR the MSB of s with x, assign to MSB of s
    s[0] = x; // Assign x to LSB of s

    // Statement 2
    s[1] = ~s[1] & x; // Invert the middle bit of s and AND with x, assign to middle bit of s

    // Statement 3
    s[0] = ~s[0] | x; // Invert the LSB of s and OR with x, assign to LSB of s
end

assign z = ~(|s); // Assign the NOT of the OR of all bits of s to output z

endmodule
