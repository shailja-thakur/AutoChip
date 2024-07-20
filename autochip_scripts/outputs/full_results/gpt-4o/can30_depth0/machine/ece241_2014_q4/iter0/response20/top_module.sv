module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s;
    
    initial begin
        s = 3'b000;
    end

    always @(posedge clk) begin
        // Update MSB of s
        s[2] <= x ^ s[2];
        // Update middle bit of s
        s[1] <= x & ~s[1];
        // Update LSB of s
        s[0] <= x | ~s[0];
    end

    always @(*) begin
        z = ~|s; // Apply OR to all bits of s, then NOT the result
    end

endmodule
