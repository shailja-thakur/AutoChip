module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        // MSB operation (s[2])
        s[2] = x ^ s[2]; // x XOR MSB
        // Middle bit operation (s[1])
        s[1] = x & ~s[1]; // x AND NOT middle bit
        // LSB operation (s[0])
        s[0] = x | ~s[0]; // x OR NOT LSB
    end

    // Assign output z
    assign z = ~|s; // NOT OR all bits of s

endmodule
