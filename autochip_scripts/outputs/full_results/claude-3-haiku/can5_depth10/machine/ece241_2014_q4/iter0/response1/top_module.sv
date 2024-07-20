module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b0; // 3-bit register s, initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s is XOR of x and MSB of s
    s[0] = x; // LSB of s is assigned x

    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s is AND of x and NOT of middle bit of s

    // Statement 3
    s[0] = x | ~s[0]; // LSB of s is OR of x and NOT of LSB of s
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is NOT of OR of all bits of s

endmodule
