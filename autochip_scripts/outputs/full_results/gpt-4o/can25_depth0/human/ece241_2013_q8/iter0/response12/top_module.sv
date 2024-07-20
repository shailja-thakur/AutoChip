module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state, waiting for '1'
        S1 = 2'b01, // '1' detected, waiting for '0'
        S2 = 2'b10  // '10' detected, waiting for '1'
    } state_t;
    
    state_t current_state, next_state;
    
    always_ff @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0; // Reset to the initial state S0
        else
            current_state <= next_state; // Update state to the next state
    end
    
    always_comb begin
        // Default next state and output values
        next_state = current_state;
        z = 1'b0;
        
        case (current_state)
            S0: begin
                if (x)
                    next_state = S1; // Transition to S1 if '1' is detected
                else
                    next_state = S0; // Remain in S0 otherwise
            end
            
            S1: begin
                if (x)
                    next_state = S1; // Stay in S1 if another '1' detected
                else
                    next_state = S2; // Transition to S2 if '0' is detected
            end
            
            S2: begin
                if (x) begin
                    next_state = S1; // Detect '1' after '10' sequence, transition back to S1
                    z = 1'b1; // '101' sequence detected
                end
                else
                    next_state = S0; // Transition back to S0 if another '0' detected
            end
        endcase
    end
    
endmodule
