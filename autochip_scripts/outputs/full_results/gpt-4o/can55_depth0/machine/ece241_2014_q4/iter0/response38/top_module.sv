module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        s[2] <= s[2] ^ x;          // MSB
        s[0] <= x;                 // LSB

        s[1] <= x & ~s[1];         // Middle bit
        s[0] <= x | ~s[0];         // LSB
    end

    assign z = ~(|s); // NOT applied to OR of all bits of s

endmodule
