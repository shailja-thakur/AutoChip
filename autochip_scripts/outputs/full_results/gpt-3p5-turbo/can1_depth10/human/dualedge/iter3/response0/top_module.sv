module top_module(
    input clk,
    input d,
    output reg q);

    reg q_prev;

    always @(posedge clk or negedge clk)
    begin
        if (clk)
        begin
            q_prev <= q;
            q <= d & ~q_prev;
        end
    end

endmodule
