module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    s[2] = s[2] ^ x; // MSB of s (s[2]) is XOR of x and previous MSB
    s[0] = x; // LSB of s (s[0]) is assigned the value of x

    s[1] = ~s[1]; // Middle bit of s (s[1]) is negated
    s[1] = s[1] & x; // Middle bit of s (s[1]) is ANDed with x

    s[0] = ~s[0]; // LSB of s (s[0]) is negated
    s[0] = s[0] | x; // LSB of s (s[0]) is ORed with x
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the negation of the OR of all bits of s

endmodule
