module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

    // Define the states
    typedef enum logic [1:0] {
        S0, // Initial state
        S1, // State after detecting the first '1'
        S2  // State after detecting '10'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default next state and output
        next_state = current_state;
        z = 0;

        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
            end
            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1; // Stay in S1 if '1' is again detected 
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1; // Output is asserted when sequence '101' is detected
                end
                else
                    next_state = S0;
            end
        endcase
    end

endmodule
