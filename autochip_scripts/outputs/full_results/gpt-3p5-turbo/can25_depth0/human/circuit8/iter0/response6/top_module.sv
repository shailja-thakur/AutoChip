module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state1, state2;

always @(posedge clock) begin
    if (state1 == 0) begin
        if (a == 1) begin
            p <= 1;
        end else if (a == 0) begin
            p <= 0;
        end
    end

    if (state2 == 1) begin
        if (a == 1) begin
            q <= 1;
        end else if (a == 0) begin
            q <= 0;
        end
    end

    if (p == 1 && q == 1) begin
        state1 <= 0;
        state2 <= 1;
    end else begin
        state1 <= 1;
        state2 <= 0;
    end
end

endmodule
