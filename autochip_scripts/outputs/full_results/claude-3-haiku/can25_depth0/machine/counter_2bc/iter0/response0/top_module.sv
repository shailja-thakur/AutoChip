module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'd1; // Reset to state 1
        end
        else if (train_valid) begin
            if (train_taken && state < 2'd3) begin
                state <= state + 2'd1; // Transition to next state
            end
            else if (!train_taken && state > 2'd0) begin
                state <= state - 2'd1; // Transition to previous state
            end
            // else, state remains unchanged
        end
        // else, state remains unchanged
    end

endmodule
