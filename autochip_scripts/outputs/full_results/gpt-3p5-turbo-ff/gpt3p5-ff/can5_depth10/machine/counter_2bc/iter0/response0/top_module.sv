module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Create internal register to hold the current state
    logic [1:0] current_state;

    // Use an always_ff block for sequential logic
    always_ff @(posedge clk or negedge areset)
    begin
        if (areset == 0) // Asynchronous reset
            current_state <= 2'b01; // Reset to state 1
        else if (train_valid == 1) // Transition between states based on taken signal
        begin
            if (train_taken == 1 && current_state < 2'b11)
                current_state <= current_state + 2'b01; // Transition to next state
            else if (train_taken == 0 && current_state > 2'b00)
                current_state <= current_state - 2'b01; // Transition to previous state
        end
    end

    // Assign the current state to the output
    assign state = current_state;

endmodule
