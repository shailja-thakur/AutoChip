module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state signal
    logic [1:0] current_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset state machine to state 1
            current_state <= 2'b01;
        end else if (train_valid) begin
            case (current_state)
                2'b00: begin
                    // Stay in state 0 if taken signal not asserted
                    if (!train_taken) begin
                        current_state <= 2'b00;
                    end
                    // Transition to next state if taken signal asserted
                    else begin
                        current_state <= 2'b01;
                    end
                end
                2'b01: begin
                    // Transition to next state if taken signal asserted
                    if (train_taken) begin
                        current_state <= 2'b10;
                    end
                    // Stay in state 1 if taken signal not asserted
                    else begin
                        current_state <= 2'b01;
                    end
                end
                2'b10: begin
                    // Transition to next state if taken signal asserted
                    if (train_taken) begin
                        current_state <= 2'b11;
                    end
                    // Stay in state 2 if taken signal not asserted
                    else begin
                        current_state <= 2'b10;
                    end
                end
                2'b11: begin
                    // Stay in state 3 if taken signal not asserted
                    if (!train_taken) begin
                        current_state <= 2'b11;
                    end
                    // Transition to previous state if taken signal asserted
                    else begin
                        current_state <= 2'b10;
                    end
                end
            endcase
        end
    end

    // Assign current_state to the output state
    assign state = current_state;

endmodule
