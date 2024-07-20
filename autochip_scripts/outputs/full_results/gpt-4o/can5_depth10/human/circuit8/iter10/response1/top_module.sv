module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg q_next;

    always @(posedge clock) begin
        if (clock) begin
            p <= a;
            q_next <= p;
        end
    end

    always @(negedge clock) begin
        if (!clock) begin
            q <= q_next;
        end
    end
endmodule
