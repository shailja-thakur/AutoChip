module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum int {S0, S1, S2} state_t;
    state_t state, next_state;

    // State transition and output logic
    always @(*) begin
        // Default assignments
        z = 0;
        next_state = state;

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
                    z = 1;  // Sequence 101 detected
                end else
                    next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

    // State register
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
