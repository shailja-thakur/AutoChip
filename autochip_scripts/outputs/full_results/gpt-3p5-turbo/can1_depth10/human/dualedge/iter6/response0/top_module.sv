module top_module(
    input clk,
    input d,
    output reg q);

    reg q_prev;
    reg q_next;

    always @(posedge clk)
    begin
        q_prev <= q;
        q_next <= d & ~q_prev;
        q <= q_next;
    end

endmodule
