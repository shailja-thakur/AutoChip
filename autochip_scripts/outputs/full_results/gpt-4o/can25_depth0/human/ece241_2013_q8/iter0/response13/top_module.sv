module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S0, // Initial state
        S1, // State after seeing '1'
        S2  // State after seeing '10'
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic (Next state logic)
    always @(*) begin
        case (state)
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S1 : S2;
            S2: next_state = (x) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // State register
    always @(negedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            z <= 0;
        else
            z <= (state == S2 && x);
    end

endmodule
