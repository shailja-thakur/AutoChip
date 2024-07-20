module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg p_next, q_next;

    always @(*) begin
        p_next = p;
        q_next = q;
        if (clock == 1'b1) begin
            p_next = a;
            // q maintains its value till next clock falling edge
        end
    end

    always @(posedge clock or negedge clock) begin
        if (~clock) begin // Falling edge
            q <= p;
        end else begin // Rising edge
            p <= p_next;
        end
    end
endmodule
