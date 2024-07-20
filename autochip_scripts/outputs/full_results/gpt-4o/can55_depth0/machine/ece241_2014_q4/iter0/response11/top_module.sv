module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;
    
    always @(posedge clk) begin
        // MSB of s
        s[2] <= x ^ s[2];
        // Middle bit of s
        s[1] <= x & ~s[1];
        // LSB of s
        s[0] <= x | ~s[0];
    end

    assign z = ~(|s);
endmodule
