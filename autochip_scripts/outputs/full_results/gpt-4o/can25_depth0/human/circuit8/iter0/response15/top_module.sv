module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg p_state, q_state;

    always @(posedge clock) begin
        if (a) begin
            p_state <= 1;
        end else begin
            p_state <= 0;
        end
    end

    always @(negedge clock) begin
        if (a) begin
            q_state <= 1;
        end else begin
            q_state <= 0;
        end
        p <= p_state;
        q <= q_state;
    end

endmodule
