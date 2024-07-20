module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter STATE_A = 1'b0, STATE_B = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B; // Reset to initial state B
    end
    else begin
        case (state)
            STATE_A: begin
                if (in) begin
                    state <= STATE_A; // Transition to A if in is high
                end
                else begin
                    state <= STATE_B; // Transition to B if in is low
                end
            end
            STATE_B: begin
                if (in) begin
                    state <= STATE_B; // Transition to B if in is high
                end
                else begin
                    state <= STATE_A; // Transition to A if in is low
                end
            end
        endcase
    end
end

always @* begin
    if (state == STATE_B) begin
        out = 1'b1; // Set output high if in state B
    end
    else begin
        out = 1'b0; // Set output low if in state A
    end
end

endmodule
