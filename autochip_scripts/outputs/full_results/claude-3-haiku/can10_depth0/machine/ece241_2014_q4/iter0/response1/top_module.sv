module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

always @(posedge clk) begin
    s[2] = s[2] ^ x; // MSB of s is XOR of s[2] and x
    s[0] = x; // LSB of s is assigned x

    s[1] = ~s[1]; // Middle bit of s is negated
    s[1] = s[1] & x; // Middle bit of s is ANDed with x

    s[0] = ~s[0]; // LSB of s is negated
    s[0] = s[0] | x; // LSB of s is ORed with x
end

assign z = ~(s[2] | s[1] | s[0]); // z is the negation of the OR of all bits of s

endmodule
