module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 0,
        S1 = 1,
        S2 = 2,
        S3 = 3
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_comb begin
        next_state = current_state; // Default to current state
        
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < S3) begin
                    next_state = current_state + 1;
                end
            end else begin
                if (current_state > S0) begin
                    next_state = current_state - 1;
                end
            end
        end
    end

    // State update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= S1; // Reset to state 1
        end else begin
            current_state <= next_state;
        end
    end

    // Output the current state
    assign state = current_state;

endmodule
