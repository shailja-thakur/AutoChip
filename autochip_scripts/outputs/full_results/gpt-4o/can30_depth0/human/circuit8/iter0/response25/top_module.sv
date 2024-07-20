module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg q_next;

    always @(posedge clock) begin
        if (a) begin
            p <= 1;
        end
        else begin
            p <= 0;
        end
    end

    always @(negedge clock) begin
        q_next <= p;
        q <= q_next;
    end

endmodule
