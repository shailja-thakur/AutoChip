module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    // State definition
    typedef enum reg [2:0] {
        S     = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        Done  = 3'b100
    } state_t;
    
    // State variables
    state_t current_state, next_state;
    
    // Sequential logic (state transition)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end
    
    // Combinational logic (next state logic)
    always @(*) begin
        case (current_state)
            S:    next_state = data ? S1 : S;
            S1:   next_state = data ? S11 : S;
            S11:  next_state = data ? S11 : S110;
            S110: next_state = data ? Done : S;
            Done: next_state = Done;
            default: next_state = S;
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == Done)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end

endmodule
