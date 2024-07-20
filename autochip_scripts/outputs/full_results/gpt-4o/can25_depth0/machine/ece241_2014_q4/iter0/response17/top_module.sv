module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s = 3'b000;  // Register s with initial value of 0

    always @(posedge clk) begin
        // Statement 1
        s[2] = x ^ s[2];  // MSB of s is XORed with x

        // Statement 2
        s[1] = x & ~s[1]; // Middle bit of s is ANDed with the NOT of middle bit

        // Statement 3
        s[0] = x | ~s[0]; // LSB of s is ORed with the NOT of LSB
    end

    // Assign output z
    assign z = ~(|s); // OR all bits of s, then apply NOT operator

endmodule
