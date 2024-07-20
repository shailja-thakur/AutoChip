module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s = 3'b000; // Register s with an initial value of 0

    always @(posedge clk) begin
        // Statement 1
        s[2] <= x ^ s[2]; // MSB: XOR x with MSB of s
        // Statement 2
        s[1] <= x & ~s[1]; // Middle bit: AND x with NOT of middle bit of s
        // Statement 3
        s[0] <= x | ~s[0]; // LSB: OR x with NOT of LSB of s
    end

    // Assign output z
    assign z = ~|s; // OR all bits of s, then NOT the result

endmodule
