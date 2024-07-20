module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,  // Initial state
        S1 = 2'b01,  // Detected '1'
        S2 = 2'b10   // Detected '1' followed by '0'
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;  // Default to no state change
        z = 1'b0;            // Default output
        
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            
            S1: begin
                if (!x)
                    next_state = S2;
            end
            
            S2: begin
                if (x)
                    next_state = S1;
                    z = 1'b1; // Recognized "101"
                else
                    next_state = S0;
            end
        endcase
    end

endmodule
