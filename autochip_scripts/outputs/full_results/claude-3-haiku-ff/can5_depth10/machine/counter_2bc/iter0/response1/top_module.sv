module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'd1; // Reset the state to 1
        end
        else if (train_valid) begin
            case (state)
                2'd0: begin
                    if (train_taken) begin
                        state <= 2'd1; // Transition to state 1
                    end
                    else begin
                        state <= 2'd0; // Remain in state 0
                    end
                end
                2'd1: begin
                    if (train_taken) begin
                        state <= 2'd2; // Transition to state 2
                    end
                    else begin
                        state <= 2'd0; // Transition to state 0
                    end
                end
                2'd2: begin
                    if (train_taken) begin
                        state <= 2'd3; // Transition to state 3
                    end
                    else begin
                        state <= 2'd1; // Transition to state 1
                    end
                end
                2'd3: begin
                    if (train_taken) begin
                        state <= 2'd3; // Remain in state 3
                    end
                    else begin
                        state <= 2'd2; // Transition to state 2
                    end
                end
                default: begin
                    state <= 2'd1; // Reset the state to 1 in case of an unknown state
                end
            endcase
        end
        else begin
            state <= state; // Remain in the current state if train_valid is not asserted
        end
    end

endmodule
