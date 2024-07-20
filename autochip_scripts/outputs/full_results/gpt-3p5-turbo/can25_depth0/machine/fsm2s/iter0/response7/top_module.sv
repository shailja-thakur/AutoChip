module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 1'b0;  // Initialize state to A
    end else begin
        state <= next_state;  // Update state based on next state
    end
end

always @(state, j, k) begin
    case (state)
        1'b0: begin  // State A
            if (j) begin
                next_state = 1'b1;  // Transition to state B
            end else begin
                next_state = 1'b0;  // Remain in state A
            end
        end
        
        1'b1: begin  // State B
            if (k) begin
                next_state = 1'b0;  // Transition to state A
            end else begin
                next_state = 1'b1;  // Remain in state B
            end
        end
    endcase
end

assign out = state;  // Output is high when state is B and low when state is A

endmodule
