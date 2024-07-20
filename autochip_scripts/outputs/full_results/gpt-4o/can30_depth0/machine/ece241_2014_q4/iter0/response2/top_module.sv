module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] s = 3'b000; // 3-bit register with initial value 0

    always @(posedge clk) begin
        // Statement 1
        s[2] <= x ^ s[2];
        // Statement 2
        s[1] <= x & ~s[1];
        // Statement 3
        s[0] <= x | ~s[0];
    end

    assign z = ~(|s); // OR operator applied to all bits of s, then NOT operator applied to the result

endmodule
