module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S     = 3'd0,
        S1    = 3'd1,
        S11   = 3'd2,
        S110  = 3'd3,
        Done  = 3'd4
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Sequential logic - state transition on clock edge and reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end

    // Combinational logic - determining next state
    always @(*) begin
        case (current_state)
            S:     next_state = data ? S1 : S;
            S1:    next_state = data ? S11 : S;
            S11:   next_state = data ? S11 : S110;
            S110:  next_state = data ? Done : S;
            Done:  next_state = Done;
            default: next_state = S; // Default state
        endcase
    end

    // Output logic
    assign start_shifting = (current_state == Done);

endmodule
