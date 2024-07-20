module top_module(
    input clk,
    input d,
    output reg q);

    reg q_prev;
    reg q_next;
    reg clk_prev;

    always @(posedge clk)
    begin
        clk_prev <= clk;
        
        if (!clk_prev && !clk)
        begin
            q_prev <= q;
            q_next <= d & q_prev;
        end
        else if (clk_prev && !clk)
        begin
            q_prev <= q_next;
            q_next <= d & q_prev;
        end
        
        q <= q_next;
    end

endmodule
