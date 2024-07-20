module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Register to hold the current state
    logic [1:0] current_state;

    always_ff @(posedge clk or posedge areset) begin
        // Reset the state machine to state 1 on asynchronous reset
        if (areset) begin
            current_state <= 2'b01;
        end
        else begin
            // Transition between states based on the taken signal
            if (train_valid) begin
                if (train_taken && current_state < 2'b11) begin
                    // Transition to the next state if taken signal is asserted and current state is less than 3
                    current_state <= current_state + 2'b01;
                end
                else if (!train_taken && current_state > 2'b00) begin
                    // Transition to the previous state if taken signal is not asserted and current state is greater than 0
                    current_state <= current_state - 2'b01;
                end
                // If none of the above conditions are met, stay in the current state
            end
        end
    end

    // Assign the current state to the output
    assign state = current_state;

endmodule
