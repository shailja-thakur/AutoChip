module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {STATE_A, STATE_B} state_t;
    state_t current_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (j) ? STATE_B : STATE_A;
            STATE_B: next_state = (k) ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    always @(current_state) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
