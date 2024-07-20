module top_module (
    input clk,
    input x,
    output z
);

    reg [2:0] s = 3'b000;
    
    always @(posedge clk) begin
        // Statement 1: MSB (s[2])
        s[2] <= s[2] ^ x;
        // Statement 2: Middle bit (s[1])
        s[1] <= (~s[1]) & x;
        // Statement 3: LSB (s[0])
        s[0] <= x | (~s[0]);
    end
    
    assign z = ~(|s); // OR all bits of s, then NOT the result to assign to z

endmodule
