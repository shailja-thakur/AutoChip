module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    always_ff @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to state 1
        end
        else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 2'b01; // Transition to next state
            end
            else if (!train_taken && state > 2'b00) begin
                state <= state - 2'b01; // Transition to previous state
            end
            // Otherwise, remain in current state
        end
    end

endmodule
