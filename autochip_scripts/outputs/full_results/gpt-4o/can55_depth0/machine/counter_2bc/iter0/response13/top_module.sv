module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    // Define the possible states
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // Asynchronous reset logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S1;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state; // Default state is to stay in the current state
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
