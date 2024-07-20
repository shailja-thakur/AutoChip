module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after detecting '1'
        S2 = 2'b10  // State after detecting '10'
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        z = 1'b0; // Default output
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Detected sequence "101"
                end else
                    next_state = S0;
            end

            default: next_state = S0;
        endcase
    end
    
endmodule
