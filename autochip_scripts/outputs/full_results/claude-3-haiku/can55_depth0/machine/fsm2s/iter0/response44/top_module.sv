module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state;

// Initialize the state to A
initial begin
    state = 1'b0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset the state to A
        state <= 1'b0;
    end
    else begin
        case (state)
            1'b0: // State A
                if (j) begin
                    // Transition to state B
                    state <= 1'b1;
                end
                else begin
                    // Remain in state A
                    state <= 1'b0;
                end
            1'b1: // State B
                if (k) begin
                    // Transition to state A
                    state <= 1'b0;
                end
                else begin
                    // Remain in state B
                    state <= 1'b1;
                end
        endcase
    end
end

always @(*) begin
    // Assign the output based on the current state
    out = state;
end

endmodule
