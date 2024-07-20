module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state, waiting for '1'
        S1 = 2'b01, // Saw '1', waiting for '0'
        S2 = 2'b10  // Saw '10', waiting for '1'
    } state_t;

    state_t state, next_state;

    // State transition logic
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
        z = 1'b0;

        case (state)
            S0: begin
                if (x)
                    next_state = S1;
            end

            S1: begin
                if (!x)
                    next_state = S2;
                else
                    next_state = S1; // Stay in S1 if '1' again
            end

            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Recognized "101"
                end else
                    next_state = S0; // Restart if '0' again
            end

            default: next_state = S0;
        endcase
    end

endmodule
