module top_module (
    input clk,
    input x,
    output reg z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        // MSB operation
        s[2] <= x ^ s[2];
        // Middle bit operation
        s[1] <= x & ~s[1];
        // LSB operation
        s[0] <= x | ~s[0];
    end

    always @(*) begin
        z = ~(|s);
    end
endmodule
