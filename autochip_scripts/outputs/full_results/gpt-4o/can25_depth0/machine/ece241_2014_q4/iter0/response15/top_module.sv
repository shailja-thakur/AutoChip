module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s;

    // Initialize the register s with 0
    initial begin
        s = 3'b000;
    end

    always @(posedge clk) begin
        // Statement 1
        s[2] <= s[2] ^ x;
        s[0] <= x;

        // Statement 2
        s[1] <= x & ~s[1];

        // Statement 3
        s[0] <= x | ~s[0];
    end

    // Assign output z
    assign z = ~(|s);

endmodule
