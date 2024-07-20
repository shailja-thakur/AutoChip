module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000;

always @(posedge clk) begin
    // Statement 1
    s[2] <= s[2] ^ x;
    // Assign the value of x to the LSB of s
    s[0] <= x | ~s[0];
    // Statement 2
    s[1] <= (x & ~s[1]);
end

// Assign output z
assign z = ~(|s);

endmodule
