module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b0; // 3-bit register s with initial value 0

always @(posedge clk) begin
    // Statement 1
    s[2] = s[2] ^ x; // MSB of s is XOR of x and previous MSB
    s[0] = x;       // LSB of s is assigned x

    // Statement 2
    s[1] = s[1] & ~x; // Middle bit of s is AND of previous middle bit and inverted x

    // Statement 3
    s[0] = s[0] | ~x; // LSB of s is OR of previous LSB and inverted x
end

assign z = ~(|s); // Output z is the NOT of the OR of all bits of s

endmodule
