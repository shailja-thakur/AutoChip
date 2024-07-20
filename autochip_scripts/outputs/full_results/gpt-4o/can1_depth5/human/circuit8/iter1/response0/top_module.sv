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

    always @(posedge clock or negedge clock) begin
        if (!clock) begin
            q <= q_next;
        end
        else begin
            p_next <= a;
        end
    end

    always @(*) begin
        p_next = p;
        q_next = q;
        if (clock == 1'b1 && a == 1'b1) begin
            p_next = 1;
        end
        if (clock == 1'b0 && p == 1'b1) begin
            q_next = 1;
        end
    end

endmodule
