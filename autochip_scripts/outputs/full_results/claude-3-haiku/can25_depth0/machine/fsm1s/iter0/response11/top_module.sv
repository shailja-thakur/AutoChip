module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter STATE_A = 0, STATE_B = 1;
reg [0:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B; // Reset to initial state B
    end else begin
        case (state)
            STATE_A: begin
                if (in) begin
                    state <= STATE_A; // Transition to A if in is high
                end else begin
                    state <= STATE_B; // Transition to B if in is low
                end
            end
            STATE_B: begin
                if (in) begin
                    state <= STATE_B; // Transition to B if in is high
                end else begin
                    state <= STATE_A; // Transition to A if in is low
                end
            end
        endcase
    end
end

always @* begin
    out = (state == STATE_B) ? 1'b1 : 1'b0; // Output is high if in state B, low otherwise
end

endmodule
