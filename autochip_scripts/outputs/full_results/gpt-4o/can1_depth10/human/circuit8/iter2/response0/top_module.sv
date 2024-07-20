module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_next;
reg q_next;

always @(posedge clock or negedge clock) begin
    if (!clock) begin
        q <= q_next;
    end else begin
        p <= p_next;
    end
end

always @(*) begin
    if (clock) begin
        if (a == 1)
            p_next = 1;
        else
            p_next = 0;
    end else begin
        if (a == 1)
            q_next = 1;
        else
            q_next = p;
    end
end

endmodule
