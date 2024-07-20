module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s;

    // Initialize s to 0
    initial begin
        s = 3'b000;
    end

    always @(posedge clk) begin
        // MSB of s is s[2]
        s[2] = x ^ s[2];
        
        // Middle bit of s is s[1]
        s[1] = x & ~s[1];
        
        // LSB of s is s[0]
        s[0] = x | ~s[0];
    end

    // Assign output z
    always @* begin
        z = ~(|s);
    end
endmodule
