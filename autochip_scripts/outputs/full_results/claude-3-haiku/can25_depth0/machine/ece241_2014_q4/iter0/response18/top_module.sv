module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = s[2] ^ x; // MSB of s is XOR'd with x
    s[0] = x; // LSB of s is assigned x

    // Statement 2
    s[1] = s[1] & ~x; // Middle bit of s is AND'd with negated x

    // Statement 3
    s[0] = s[0] | ~x; // LSB of s is OR'd with negated x
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the negation of the OR of all bits of s

endmodule
