module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s = 3'b000; // 3-bit register s, initial value is 0

    always @(posedge clk) begin
        s[2] <= x ^ s[2]; // Statement 1
        s[1] <= x & ~s[1]; // Statement 2
        s[0] <= x | ~s[0]; // Statement 3
    end

    always @(*) begin
        z = ~|s; // OR all bits of s, then NOT the result
    end

endmodule
