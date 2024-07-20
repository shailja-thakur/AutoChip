module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        // Statement 1: Implementing cascade for s[2] and s[0]
        s[2] <= x ^ s[2]; // MSB of s
        s[0] <= x; // LSB of s

        // Statement 2: Implementing logic for s[1]
        s[1] <= x & ~s[1];

        // Statement 3: Implementing logic for s[0]
        s[0] <= x | ~s[0];
    end

    // Assigning z
    assign z = ~(|s);

endmodule
