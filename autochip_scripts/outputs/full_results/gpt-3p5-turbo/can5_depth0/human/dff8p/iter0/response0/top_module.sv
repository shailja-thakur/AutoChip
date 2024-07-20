module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);
    reg [7:0] q_internal;
    
    always @(negedge clk) begin
        if (reset)
            q_internal <= 8'b00110100;
        else
            q_internal <= d;
    end
    
    always @*
        q = q_internal;
    
endmodule
