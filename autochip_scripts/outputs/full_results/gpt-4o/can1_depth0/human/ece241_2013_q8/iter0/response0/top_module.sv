module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after detecting '1'
        S2  // State after detecting '10'
    } state_t;
    
    state_t current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        z = (current_state == S2 && x == 1);
    end

    // State transition
    always @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

endmodule
