module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next, q_next;

    always @(posedge clock) begin
        p <= p_next;
    end

    always @(negedge clock) begin
        q <= q_next;
    end

    always @* begin
        p_next = a & clock ? 1 : 0;
        q_next = a | p ? 1 : q;
    end

endmodule
