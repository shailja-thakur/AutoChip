module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

reg state; // Parameterized state register

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B; // Reset state to initial state B
    end
    else begin
        if (state == STATE_A) begin
            if (in) begin
                state <= STATE_A; // Stay in state A if in is high
            end
            else begin
                state <= STATE_B; // Transition to state B if in is low
            end
        end
        else begin // state == STATE_B
            if (in) begin
                state <= STATE_B; // Stay in state B if in is high
            end
            else begin
                state <= STATE_A; // Transition to state A if in is low
            end
        end
    end
end

assign out = (state == STATE_B); // Output is high when in state B, low otherwise

endmodule
