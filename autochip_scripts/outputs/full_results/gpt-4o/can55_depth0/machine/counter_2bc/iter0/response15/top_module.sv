module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the state register
    logic [1:0] current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= 2'b01; // Reset state to 1
        end else if (train_valid) begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to no state change
        case (current_state)
            2'b00: begin
                if (train_taken) begin
                    next_state = 2'b01; // Transition to state 1
                end
            end
            2'b01: begin
                if (train_taken) begin
                    next_state = 2'b10; // Transition to state 2
                end else begin
                    if (!train_taken) begin
                        next_state = 2'b00; // Transition to state 0
                    end
                end
            end
            2'b02: begin
                if (train_taken) begin
                    next_state = 2'b11; // Transition to state 3
                end else begin
                    if (!train_taken) begin
                        next_state = 2'b01; // Transition to state 1
                    end
                end
            end
            2'b03: begin
                if (!train_taken) begin
                    next_state = 2'b10; // Transition to state 2
                end
            end
        endcase
    end

    // Assign the current state to output state
    assign state = current_state;

endmodule
