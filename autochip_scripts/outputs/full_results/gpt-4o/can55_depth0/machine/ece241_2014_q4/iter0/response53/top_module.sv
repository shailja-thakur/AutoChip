module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000; // 3-bit register initialized to 0

    always @(posedge clk) begin
        // Statement 1
        s[2] <= x ^ s[2]; // MSB of s is updated
        // Statement 2
        s[1] <= x & ~s[1]; // middle bit of s is updated
        // Statement 3
        s[0] <= x | ~s[0]; // LSB of s is updated
    end

    // Assign output z
    assign z = ~(|s); // OR all bits of s and then NOT the result

endmodule
