module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // Register s is 3 bits and its initial value is 0

always @(posedge clk) begin
    // Cascade notation to represent the state of s
    // First element is the MSB of s, second element is the middle bit, and third element is the LSB
    s[2] = s[2] ^ x; // Statement 1: The MSB of s is s[2], XOR with x, and assign x to the LSB
    s[1] = ~s[1] & x; // Statement 2: The middle bit of s is s[1], NOT and AND with x
    s[0] = ~s[0] | x; // Statement 3: The LSB of s is s[0], NOT and OR with x
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the NOT of the OR of all bits of s

endmodule
