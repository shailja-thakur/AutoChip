module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next, q_next;

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) p_next = 1;
            else p_next = 0;
        end else begin
            q_next = p;
        end
        p <= p_next;
        q <= q_next;
    end

endmodule
