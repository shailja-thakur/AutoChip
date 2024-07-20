module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State register
    logic [1:0] current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= 2'b01; // Reset to state 1
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state;  // Default is to stay in the same state
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < 3)
                    next_state = current_state + 1;
                else
                    next_state = current_state; // Stay in the same state if already 3
            end else begin
                if (current_state > 0)
                    next_state = current_state - 1;
                else
                    next_state = current_state; // Stay in the same state if already 0
            end
        end
    end

    // Output state
    assign state = current_state;

endmodule
