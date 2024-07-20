module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // Current state and next state variables
    reg state, next_state;
    
    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // reset to state A on reset
        else
            state <= next_state;  // transition to next state otherwise
    end
    
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;  // state transition when j is high
                else
                    next_state = A;  // remain in state A when j is low
                out = 1'b0;  // output is low when in state A
            end
            B: begin
                if (k)
                    next_state = A;  // state transition when k is high
                else
                    next_state = B;  // remain in state B when k is low
                out = 1'b1;  // output is high when in state B
            end
            default: begin
                next_state = A;  // in case of error, go to state A
                out = 1'b0;
            end
        endcase
    end
endmodule
