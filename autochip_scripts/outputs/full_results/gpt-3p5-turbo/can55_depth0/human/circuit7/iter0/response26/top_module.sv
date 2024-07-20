module top_module (
    input clk,
    input a, 
    output reg q
);
    
    reg q_next;
    
    always @(posedge clk) begin
        if (a == 0) begin
            q_next <= q;
        end else begin
            q_next <= 1;
        end
    end
    
    always @(posedge clk) begin
        q <= q_next;
    end
    
endmodule
