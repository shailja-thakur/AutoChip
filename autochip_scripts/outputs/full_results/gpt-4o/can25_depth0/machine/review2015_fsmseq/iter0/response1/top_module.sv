module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    
    // State encoding
    typedef enum int {S, S1, S11, S110, Done} state_t;
    state_t state, next_state;
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S:    if (data) next_state = S1; else next_state = S;
            S1:   if (data) next_state = S11; else next_state = S;
            S11:  if (data) next_state = S11; else next_state = S110;
            S110: if (data) next_state = Done; else next_state = S;
            Done: next_state = Done;
            default: next_state = S; // Should not happen
        endcase
    end
    
    // Output logic
    always @(state) begin
        if (state == Done)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
