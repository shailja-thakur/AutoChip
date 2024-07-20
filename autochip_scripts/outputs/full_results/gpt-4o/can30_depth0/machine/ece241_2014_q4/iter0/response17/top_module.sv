module top_module (
    input clk,
    input x,
    output reg z
);

reg [2:0] s;

initial begin
    s = 3'b000; // Initial value of s is 0
end

always @(posedge clk) begin
    s[2] <= x ^ s[2];           // The value of x is exclusive ORed with the MSB of s
    s[1] <= x & ~s[1];          // The value of x is ANDed with the NOT of the middle bit of s
    s[0] <= x | ~s[0];          // The value of x is ORed with the NOT of the LSB of s
end

always @(posedge clk) begin
    z <= ~(s[2] | s[1] | s[0]); // The OR operator is applied to all bits of s, NOT operator is applied to the result
end

endmodule
