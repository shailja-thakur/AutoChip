module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b0; // Register s is 3 bits and its initial value is 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // The MSB of s is s[2]
    s[0] = x; // The value of x is assigned to the LSB of s

    // Statement 2
    s[1] = x & ~s[1]; // The middle bit of s is s[1]

    // Statement 3
    s[0] = x | ~s[0]; // The LSB of s is s[0]
end

assign z = ~(s[2] | s[1] | s[0]); // The OR operator is applied to all bits of s, and the NOT operator is applied to the output

endmodule
