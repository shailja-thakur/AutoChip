module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'd1; // Reset to state 1 when areset is asserted
    end
    else if (train_valid) begin
        case (state)
            2'd0: begin
                if (train_taken) begin
                    state <= 2'd1; // Transition from state 0 to state 1 on train_taken
                end
                else begin
                    state <= 2'd0; // Remain in state 0 if train_taken is not asserted
                end
            end
            2'd1: begin
                if (train_taken) begin
                    state <= 2'd2; // Transition from state 1 to state 2 on train_taken
                end
                else begin
                    state <= 2'd0; // Transition from state 1 to state 0 if train_taken is not asserted
                end
            end
            2'd2: begin
                if (train_taken) begin
                    state <= 2'd3; // Transition from state 2 to state 3 on train_taken
                end
                else begin
                    state <= 2'd1; // Transition from state 2 to state 1 if train_taken is not asserted
                end
            end
            2'd3: begin
                if (train_taken) begin
                    state <= 2'd3; // Remain in state 3 if train_taken is asserted
                end
                else begin
                    state <= 2'd2; // Transition from state 3 to state 2 if train_taken is not asserted
                end
            end
            default: begin
                state <= 2'd1; // Reset to state 1 for any unexpected state
            end
        endcase
    end
    else begin
        state <= state; // Remain in the current state if train_valid is not asserted
    end
end

endmodule
