module top_module (
    input clk,
    input x,
    output reg z
);

    reg [2:0] s;

    always @(posedge clk) begin
        // Statement 1
        s[2] <= s[1] ^ x;
        s[1] <= ~s[1] & x;
        s[0] <= ~s[0] | x;
    end

    always @* begin
        // Assign output z
        z = ~(s[2] & s[1] & s[0]);
    end
    
endmodule
