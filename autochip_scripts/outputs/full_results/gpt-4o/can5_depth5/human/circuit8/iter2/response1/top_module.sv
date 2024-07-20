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

    always @(*) begin
        p_next = p;
        q_next = q;

        if (a) begin
            p_next = 1;
        end else begin
            p_next = 0;
        end

        if (!clock) begin
            q_next = p;
        end
    end

endmodule
