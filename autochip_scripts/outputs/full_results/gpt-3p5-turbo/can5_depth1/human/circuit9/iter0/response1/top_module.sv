module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    
    always @(posedge clk) begin
        // Reset condition
        if (a == 0)
            q <= 0;
        // When a is high, increment q by 1
        else if (a == 1)
            q <= q + 1;
    end
    
endmodule
