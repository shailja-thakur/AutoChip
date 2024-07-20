module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_next, q_next;

always @(posedge clock) begin
    if (a == 0) begin
        p_next = 0;
        q_next = 0;
    end else if (p == 0 && q == 0) begin
        p_next = 0;
        q_next = 0;
    end else if (p == 1 && q == 0) begin
        p_next = 0;
        q_next = 0;
    end else if (p == 1 && q == 1) begin
        p_next = 1;
        q_next = 0;
    end else if (p == 0 && q == 1) begin
        p_next = 0;
        q_next = 1;
    end
end

always @(posedge clock) begin
    p <= p_next;
    q <= q_next;
end

endmodule
