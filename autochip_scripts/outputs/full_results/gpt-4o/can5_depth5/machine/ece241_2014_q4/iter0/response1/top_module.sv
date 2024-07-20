module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        // Statement 1
        s[2] <= x ^ s[2];   // MSB of s
        // Statement 2
        s[1] <= x & ~s[1];  // Middle bit of s
        // Statement 3
        s[0] <= x | ~s[0];  // LSB of s
    end

    assign z = ~(|s);  // Apply OR to all bits of s, then apply NOT

endmodule
