module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State Definition
    typedef enum logic [1:0] {
        S0,  // Initial state
        S1,  // Got '1'
        S2   // Got '10'
    } state_t;
    
    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State Logic & Output Assignment
    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (~x)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;  // Detect the sequence "101"
                end else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
