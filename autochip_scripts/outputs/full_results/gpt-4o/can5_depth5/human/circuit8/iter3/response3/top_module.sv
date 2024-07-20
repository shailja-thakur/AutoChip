module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg p_next;

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p_next <= 1;
            end else begin
                p_next <= 0;
            end
        end else begin
            p <= p_next;
            q <= p;
        end
    end

endmodule
