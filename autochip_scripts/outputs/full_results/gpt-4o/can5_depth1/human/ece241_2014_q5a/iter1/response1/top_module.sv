module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        ZERO        = 2'd0,  // Initial zero state
        ONE         = 2'd1,  // Encounters first one and outputs complement starting from here
        COMPLEMENT  = 2'd2   // Continue complementing
    } state_t;

    state_t state, next_state;

    // State transition based on current state and input x
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= ZERO;
        else
            state <= next_state;
    end

    // Determine next state and output based on the current state and input x
    always_comb begin
        case (state)
            ZERO: begin
                z = x;  // Output same as input in the initial state
                if (x == 1)
                    next_state = COMPLEMENT;  // Transition to COMPLEMENT state if '1' is encountered
                else
                    next_state = ZERO;  // Stay in ZERO state if '0' is encountered
            end
            COMPLEMENT: begin
                z = ~x;  // Output complement of input
                next_state = COMPLEMENT;  // Stay in COMPLEMENT state indefinitely after the first '1'
            end
            default: begin
                z = x;  // Default output is same as input
                next_state = ZERO;  // Default state transition is to the initial ZERO state
            end
        endcase
    end

endmodule
