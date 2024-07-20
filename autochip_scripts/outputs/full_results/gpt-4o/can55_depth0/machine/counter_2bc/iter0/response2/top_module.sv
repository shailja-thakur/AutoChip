module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        S0 = 2'd0,
        S1 = 2'd1,
        S2 = 2'd2,
        S3 = 2'd3
    } state_t;
    
    state_t current_state, next_state;
    
    // Asynchronous reset and state assignment
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state; // Default case: stay in the same state
        if (train_valid) begin
            if (train_taken) begin
                if (current_state < S3)
                    next_state = current_state + 1;
            end else begin
                if (current_state > S0)
                    next_state = current_state - 1;
            end
        end
    end
    
    // Output logic
    assign state = current_state;

endmodule
