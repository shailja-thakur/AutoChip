module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    // Statement 1
    s[2] = s[2] ^ x; // MSB of s
    s[0] = x; // LSB of s

    // Statement 2
    s[1] = ~s[1] & x; // Middle bit of s

    // Statement 3
    s[0] = ~s[0] | x; // LSB of s
end

assign z = ~(|s); // Output z is the negation of the OR of all bits of s

endmodule
