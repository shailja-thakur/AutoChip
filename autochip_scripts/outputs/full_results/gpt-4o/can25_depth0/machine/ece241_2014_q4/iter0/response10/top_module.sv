module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s = 3'b000; // Register s is 3 bits, initialized to 0

    always @(posedge clk) begin
        // Statement 1
        s[2] = s[2] ^ x; // MSB of s is XORed with x
        s[0] = x; // LSB of s is assigned to x

        // Statement 2
        s[1] = s[1] & ~x; // Middle bit of s is ANDed with NOT of x

        // Statement 3
        s[0] = s[0] | ~x; // LSB of s is ORed with NOT of x
    end

    assign z = ~(|s); // OR all bits of s, apply NOT operator, and assign to z

endmodule
