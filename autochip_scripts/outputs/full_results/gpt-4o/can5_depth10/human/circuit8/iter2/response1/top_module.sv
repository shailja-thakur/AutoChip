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
            q_next <= q;
        end else begin
            p <= 0;
            q_next <= 0;
        end
    end

    always @(negedge clock) begin
        q <= q_next;
    end
endmodule
