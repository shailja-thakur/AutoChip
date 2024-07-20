module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] current_state;

    // Initializing the state machine to state 1 on asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b1;
        end else begin
            // Transitioning between states based on train_valid and train_taken signals
            if (train_valid) begin
                // If taken is asserted and current state is less than 3, transition to the next state
                if (train_taken && current_state < 2'b11) begin
                    current_state <= current_state + 1;
                end
                // If taken is not asserted and current state is greater than 0, transition to the previous state
                else if (!train_taken && current_state > 2'b00) begin
                    current_state <= current_state - 1;
                end
                // Otherwise, remain in the current state
                else begin
                    current_state <= current_state;
                end
            end
            // If train_valid is not asserted, remain in the current state
            else begin
                current_state <= current_state;
            end
        end
    end
    
    assign state = current_state;

endmodule
