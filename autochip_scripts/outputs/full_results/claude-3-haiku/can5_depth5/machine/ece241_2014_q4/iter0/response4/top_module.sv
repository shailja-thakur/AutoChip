module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register, initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s is exclusive OR of x and MSB of s
    s[0] = x; // LSB of s is assigned the value of x

    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s is AND of x and inverted middle bit of s

    // Statement 3
    s[0] = x | ~s[0]; // LSB of s is OR of x and inverted LSB of s
end

assign z = ~(s[2] | s[1] | s[0]); // Output z is the negation of the OR of all bits of s

endmodule
