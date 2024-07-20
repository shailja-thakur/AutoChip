module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal signals
    logic [1:0] next_state;
  
    // Saturating counter logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state == 2'b11) begin
                    next_state <= 2'b11; // Maximum value
                end else begin
                    next_state <= state + 1; // Increment state
                end
            end else begin
                if (state == 2'b00) begin
                    next_state <= 2'b00; // Minimum value
                end else begin
                    next_state <= state - 1; // Decrement state
                end
            end
        end else begin
            next_state <= state; // Keep the value unchanged when not training
        end
    end
      
    // Assign next state to current state
    always_ff@(posedge clk) begin
        state <= next_state;
    end
endmodule
