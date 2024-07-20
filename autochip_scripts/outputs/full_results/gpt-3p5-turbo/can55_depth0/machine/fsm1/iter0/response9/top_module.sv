module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    if (state) begin
        if (in) begin
            next_state <= 1'b1;
        end else begin
            next_state <= 1'b0;
        end
    end else begin
        if (in) begin
            next_state <= 1'b0;
        end else begin
            next_state <= 1'b1;
        end
    end
end

assign out = ~state;

endmodule
