module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the state variables
    logic [1:0] current_state, next_state;

    // Process the state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset to state 1
            current_state <= 2'b01;
        end else begin
            // Transition between states
            case (current_state)
                2'b00: begin
                    // Stay in state 0 if train_taken is not asserted
                    // Transition to state 1 if train_taken is asserted
                    next_state <= (train_taken) ? 2'b01 : 2'b00;
                end
                2'b01: begin
                    // Transition to state 0 if train_taken is not asserted
                    // Transition to state 2 if train_taken is asserted
                    next_state <= (train_taken) ? 2'b10 : 2'b00;
                end
                2'b10: begin
                    // Transition to state 1 if train_taken is not asserted
                    // Transition to state 3 if train_taken is asserted
                    next_state <= (train_taken) ? 2'b11 : 2'b01;
                end
                2'b11: begin
                    // Transition to state 2 if train_taken is not asserted
                    // Stay in state 3 if train_taken is asserted
                    next_state <= (train_taken) ? 2'b11 : 2'b10;
                end
            endcase
        end
    end

    // Assign the current state to the output
    always_ff @(posedge clk) begin
        state <= current_state;
        current_state <= next_state;
    end

endmodule
