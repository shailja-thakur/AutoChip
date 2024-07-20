module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg last_a;

    always @(posedge clock or negedge clock) begin
        if (~clock) begin
            last_a <= a;
        end else begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end
    end

    always @(negedge clock) begin
        if (~last_a) begin
            q <= p;
        end else begin
            q <= 0;
        end
    end

endmodule
