module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        s[2] <= x ^ s[2];        // MSB of s
        s[1] <= x & ~s[1];       // Middle bit of s
        s[0] <= x | ~s[0];       // LSB of s
    end

    assign z = ~|s;

endmodule
