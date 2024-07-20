module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s is XORed with x and assigned back to MSB
    s[0] = x; // LSB of s is assigned x

    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s is ANDed with the negation of itself and assigned back

    // Statement 3
    s[0] = x | ~s[0]; // LSB of s is ORed with the negation of itself and assigned back
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the negation of the OR of all bits of s

endmodule
