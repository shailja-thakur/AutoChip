module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    
    always_ff @(posedge clk or negedge areset) begin
        if (areset === 0) begin
            state <= 2'b01; // Reset to state 1
        end else if (train_valid) begin
            if (train_taken && state < 2'b11) begin
                state <= state + 1; // Transition to next state if taken signal is asserted and current state is less than 3
            end else if (!train_taken && state > 2'b00) begin
                state <= state - 1; // Transition to previous state if taken signal is not asserted and current state is greater than 0
            end
        end
    end
    
endmodule
