module top_module(
    input clk,
    input d,
    output reg q);

    reg q_prev;
    reg q_next;

    always @(posedge clk or negedge clk)
    begin
        if (clk)
        begin
            q_prev <= q;
            q_next <= d & ~q_prev;
        end
        q <= q_next;
    end

endmodule
