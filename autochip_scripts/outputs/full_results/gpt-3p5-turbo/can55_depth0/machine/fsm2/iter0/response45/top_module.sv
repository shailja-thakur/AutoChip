module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg next_state, state;

always @(*) begin
    if (state == A) begin
        if (j == 1'b1)
            next_state = B;
        else
            next_state = A;
    end else begin
        if (k == 1'b1)
            next_state = A;
        else
            next_state = B;
    end
end

always @(posedge clk) begin
    if (areset == 1'b1)
        state <= A;
    else
        state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
