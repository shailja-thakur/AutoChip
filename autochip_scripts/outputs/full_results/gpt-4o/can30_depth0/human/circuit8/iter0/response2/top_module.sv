module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);
    reg state_p, state_q;

    always @(posedge clock) begin
        state_q <= state_p;
        state_p <= a;
    end

    always @(posedge clock or negedge clock) begin
        if (clock == 1'b1) begin
            p <= state_p;
        end
        if (clock == 1'b0) begin
            q <= state_q;
        end
    end
endmodule
