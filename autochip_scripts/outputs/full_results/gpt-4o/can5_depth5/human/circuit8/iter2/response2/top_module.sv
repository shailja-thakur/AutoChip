module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg q_int;
    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end else begin
            q_int <= p;
        end
    end

    always @(negedge clock) begin
        q <= q_int;
    end

endmodule
