module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b0; // 3-bit register s with initial value of 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s is exclusive-ORed with x
    s[0] = x; // LSB of s is assigned the value of x

    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s is ANDed with the negation of itself

    // Statement 3
    s[0] = x | ~s[0]; // LSB of s is ORed with the negation of itself
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the negation of the OR of all bits of s

endmodule
