module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // Exclusive OR the MSB of s with x, assign to MSB
    s[0] = x; // Assign x to LSB of s

    // Statement 2
    s[1] = x & ~s[1]; // AND x with the complement of the middle bit of s, assign to middle bit

    // Statement 3
    s[0] = x | ~s[0]; // OR x with the complement of the LSB of s, assign to LSB
end

assign z = ~(s[2] | s[1] | s[0]); // Assign the complement of the OR of all bits of s to z

endmodule
