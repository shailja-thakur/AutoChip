module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    reg [3:0] q_next;
    
    always @(posedge clk) begin
        if (reset)
            q <= 1;
        else
            q <= q_next;
    end
    
    always @(q) begin
        if (q == 10)
            q_next = 1;
        else
            q_next = q + 1;
    end
    
endmodule
