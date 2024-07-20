module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next, q_next;

    always @(*) begin
        if (clock) begin
            p_next = a;
        end
        else begin
            p_next = p;
        end
    end

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            q_next = p;
        end
        else begin
            q_next = q;
        end
    end

    always @(posedge clock or negedge clock) begin
        p <= p_next;
        q <= q_next;
    end

endmodule
