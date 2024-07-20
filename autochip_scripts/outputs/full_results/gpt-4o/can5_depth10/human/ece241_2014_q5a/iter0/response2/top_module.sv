module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define states
    typedef enum logic [1:0] {
        S0, // Initial State
        S1  // Complement State
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            S0: begin
                // In S0 state, we output the same input x
                z = x;
                // Transition to S1 state when x is 1
                next_state = x ? S1 : S0;
            end
            S1: begin
                // In S1 state, we output the complement of the input x
                z = ~x;
                // Stay in S1 state
                next_state = S1;
            end
        endcase
    end
    
endmodule
