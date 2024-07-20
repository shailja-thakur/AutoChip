module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    s[2] = x ^ s[2]; // MSB of s is x XOR MSB of s
    s[1] = x & ~s[1]; // Middle bit of s is x AND (NOT middle bit of s)
    s[0] = x | ~s[0]; // LSB of s is x OR (NOT LSB of s)
end

assign z = ~(s[2] | s[1] | s[0]); // z is the NOT of the OR of all bits of s

endmodule
