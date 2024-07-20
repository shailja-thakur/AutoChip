module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg hold_p;
    reg hold_q;

    always @(posedge clock or negedge clock) begin
        if (clock) begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
        end else begin
            if (a) begin
                q <= hold_p;
            end else begin
                q <= 0;
            end
        end
        hold_p <= p;
        hold_q <= q;
    end
endmodule
