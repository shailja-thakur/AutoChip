module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after receiving '1'
        S2  // State after receiving '10'
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
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
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = 0;
            S1: z = 0;
            S2: z = x; // Detect the "101" sequence
            default: z = 0;
        endcase
    end

endmodule
