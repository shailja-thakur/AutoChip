module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s; // 3-bit register s

    // Initialize s to 0
    initial begin
        s = 3'b000;
    end

    always @(posedge clk) begin
        // Cascade notation updates
        s[2] <= x ^ s[2];       // Update MSB of s
        s[1] <= x & ~s[1];      // Update middle bit of s
        s[0] <= x | ~s[0];      // Update LSB of s
    end

    // Assign z as the NOT of the OR of all bits of s
    always @(s) begin
        z = ~|s;
    end

endmodule
