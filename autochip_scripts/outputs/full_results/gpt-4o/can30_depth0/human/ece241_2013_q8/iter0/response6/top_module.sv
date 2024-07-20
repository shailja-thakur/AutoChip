module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    // Define state encoding
    typedef enum reg [1:0] {
        S0,  // initial state
        S1,  // state after seeing '1'
        S2   // state after seeing '10'
    } state_t;
    
    state_t state, next_state;

    // State transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = state;
        z = 0;
        
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else // if x == 1
                    next_state = S1;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1; // Sequence 101 detected
                end
                else
                    next_state = S0;
            end
        endcase
    end

endmodule
