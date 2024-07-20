module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);
    
    // Declare individual D flip-flop instances
    reg [7:0] q_temp;
    reg [7:0] q_next;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            q_temp <= 8'b0;
        else
            q_temp <= q_next;
    end
    
    always @*
    begin
        q_next = d;
    end
    
    always @(posedge clk)
    begin
        q <= q_temp;
    end
    
endmodule
