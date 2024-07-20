module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S       = 3'b000,
        S1      = 3'b001,
        S11     = 3'b010,
        S110    = 3'b011,
        Done    = 3'b100
    } state_t;

    // Current state and next state registers
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S:     next_state = (data) ? S1 : S;
            S1:    next_state = (data) ? S11 : S;
            S11:   next_state = (data) ? S11 : S110;
            S110:  next_state = (data) ? Done : S;
            Done:  next_state = Done;
            default: next_state = S; // Default state
        endcase
    end

    // State update logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= S; // Reset to initial state
        else 
            state <= next_state; // Update state
    end

    // Output logic
    always @(state) begin
        if (state == Done)
            start_shifting = 1;
        else 
            start_shifting = 0;
    end

endmodule
