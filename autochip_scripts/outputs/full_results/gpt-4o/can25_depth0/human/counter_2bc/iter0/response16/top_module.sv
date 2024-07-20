module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Internal state register
    logic [1:0] next_state;
    
    // Reset condition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= 2'b01; // Reset to weakly not-taken
        else
            state <= next_state;
    end
    
    // State transitions
    always_comb begin
        next_state = state; // Default to holding state value
        
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) // Saturate at max value (3)
                    next_state = state + 2'b01;
            end else begin
                if (state > 2'b00) // Saturate at min value (0)
                    next_state = state - 2'b01;
            end
        end
    end
    
endmodule
