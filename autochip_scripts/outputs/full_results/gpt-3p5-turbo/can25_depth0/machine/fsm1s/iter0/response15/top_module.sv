module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= B; // Reset to initial state
    end else begin
        state <= next_state; // Update state with next state
    end
end

always @(*) begin
    case(state)
        A: begin
            if (in) begin
                next_state = A; // Stay in state A if in input is high
            end else begin
                next_state = B; // Transition to state B if in input is low
            end
        end
        B: begin
            if (in) begin
                next_state = B; // Stay in state B if in input is high
            end else begin
                next_state = A; // Transition to state A if in input is low
            end
        end
    endcase
end

assign out = state; // Assign output with state value

endmodule
