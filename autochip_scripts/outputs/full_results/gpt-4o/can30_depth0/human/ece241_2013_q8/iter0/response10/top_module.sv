module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after seeing '1'
        S2  // State after seeing '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        next_state = current_state; // Default to no state change
        z = 1'b0; // Default output to 0

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1; // Stay in S1 if '1' is seen again
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Detect sequence '101'
                end else
                    next_state = S0;
            end
        endcase
    end
    
endmodule
