module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] s = 3'b000; // 3-bit register s with initial value 0

always @(posedge clk) begin
    s[2] <= x ^ s[2];   // Statement 1: MSB of s
    s[1] <= x & ~s[1];  // Statement 2: Middle bit of s
    s[0] <= x | ~s[0];  // Statement 3: LSB of s
end

assign z = ~(s[2] | s[1] | s[0]); // Assign output z

endmodule
