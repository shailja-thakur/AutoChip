module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg p_next, q_next;

    always @(posedge clock) begin
        if (a == 1)
            p_next <= 1;
        else
            p_next <= p;

        if (a == 1 && p == 0)
            q_next <= 1;
        else
            q_next <= q;
    end

    always @(posedge clock) begin
        p <= p_next;
        q <= q_next;
    end

endmodule
