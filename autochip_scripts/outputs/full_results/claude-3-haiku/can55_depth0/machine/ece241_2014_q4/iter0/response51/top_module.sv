module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s initialized to 0

always @(posedge clk) begin
    // Statement 1
    s[2] = x ^ s[2]; // MSB of s
    s[0] = x; // LSB of s

    // Statement 2
    s[1] = x & ~s[1]; // Middle bit of s

    // Statement 3
    s[0] = x | ~s[0]; // LSB of s
end

assign z = ~(s[2] | s[1] | s[0]); // Output z

endmodule
